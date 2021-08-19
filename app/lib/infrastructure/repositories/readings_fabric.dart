import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:chainmetric/models/readings/readings.dart';
import 'package:flutter/services.dart';
import 'package:streams_channel2/streams_channel2.dart';
import 'package:tuple/tuple.dart';

const readingsChannel =
    "chainmetric.app.blockchain-native-sdk/contracts/readings";
const readingsEventsChannel =
    "chainmetric.app.blockchain-native-sdk/events/readings";

typedef ReadingsListener = void Function(MetricReadingPoint? point);
typedef CancelReadingsListening = void Function();

class ReadingsController {
  static const _readingsContract = MethodChannel(readingsChannel);
  static final _readingsEvents = StreamsChannel(readingsEventsChannel);

  static Future<MetricReadings?> getReadings(String? assetID) async {
    try {
      final String data = await (_readingsContract.invokeMethod("for_asset", {
        "asset": assetID,
      }) as FutureOr<String>);
      if (data.isEmpty) {
        return null;
      }
      final port = ReceivePort();
      Isolate.spawn(_unmarshalReadings, Tuple2(data, port.sendPort));
      return await port.first as MetricReadings?;
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    } on Exception catch (e) {
      print("ReadingsController.getReadings: ${e.toString()}");
    }

    return null;
  }

  static Future<MetricReadingsStream?> getStream(
      String? assetID, String? metric) async {
    try {
      final String data = await (_readingsContract
              .invokeMethod("for_metric", {"asset": assetID, "metric": metric})
          as FutureOr<String>);
      if (data.isEmpty) {
        return null;
      }
      final port = ReceivePort();
      Isolate.spawn(_unmarshalStream, Tuple2(data, port.sendPort));
      return await port.first as MetricReadingsStream?;
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    } on Exception catch (e) {
      print("ReadingsController.getStream: ${e.toString()}");
    }

    return null;
  }

  static Future<CancelReadingsListening> subscribeToStream(
      String? assetID, String? metric, ReadingsListener listener) async {
    final subscription = _readingsEvents
        .receiveBroadcastStream("posted.$assetID.$metric")
        .listen((eventArtifact) {
      listener(MetricReadingPoint.fromJson(json.decode(eventArtifact)));
    }, cancelOnError: false);

    return () => subscription.cancel();
  }

  static Future<void> _unmarshalReadings(Tuple2<String, SendPort> args) async {
    args.item2.send(MetricReadings.fromJson(json.decode(args.item1)));
  }

  static Future<void> _unmarshalStream(Tuple2<String, SendPort> args) async {
    args.item2.send(MetricReadingsStream.from(
        MetricReadingPoint.listFromJson(json.decode(args.item1))));
  }
}
