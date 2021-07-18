import 'dart:async';
import 'dart:isolate';

import 'package:chainmetric/main.dart';
import 'package:chainmetric/models/readings_model.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/services.dart';
import 'package:streams_channel/streams_channel.dart';
import 'package:tuple/tuple.dart';

const READINGS_CHANNEL = "chainmetric.app.blockchain-native-sdk/contracts/readings";
const READINGS_EVENTS_CHANNEL = "chainmetric.app.blockchain-native-sdk/events/readings";

typedef void ReadingsListener(MetricReadingPoint point);
typedef void CancelReadingsListening();

class ReadingsController {
  static final _readingsContract = MethodChannel(READINGS_CHANNEL);
  static final _readingsEvents = StreamsChannel(READINGS_EVENTS_CHANNEL);

  static Future<MetricReadings> getReadings(String assetID) async {
    try {
      String data = await _readingsContract.invokeMethod("for_asset", {
        "asset": assetID,
      }); if (data.isEmpty) {
        return null;
      }
      var port = new ReceivePort();
      Isolate.spawn(_unmarshalReadings, Tuple2(data, port.sendPort));
      return await port.first;
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    } on Exception catch (e) {
      print("ReadingsController.getReadings: ${e.toString()}");
    }

    return null;
  }

  static Future<MetricReadingsStream> getStream(String assetID, String metric) async {
    try {
      String data = await _readingsContract.invokeMethod("for_metric", {
        "asset": assetID,
        "metric": metric
      }); if (data.isEmpty) {
        return null;
      }
      var port = new ReceivePort();
      Isolate.spawn(_unmarshalStream, Tuple2(data, port.sendPort));
      return await port.first;
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    } on Exception catch (e) {
      print("ReadingsController.getStream: ${e.toString()}");
    }

    return null;
  }

  static Future<CancelReadingsListening> subscribeToStream(String assetID, String metric, ReadingsListener listener) async {
    var subscription = _readingsEvents
        .receiveBroadcastStream("posted.$assetID.$metric")
        .listen((eventArtifact) {
      listener(JsonMapper.deserialize<MetricReadingPoint>(eventArtifact));
    }, cancelOnError: false);

    return () => subscription.cancel();
  }

  static void _unmarshalReadings(Tuple2<String, SendPort> args) async {
    initJson();
    args.item2.send(JsonMapper.deserialize<MetricReadings>(args.item1));
  }

  static void _unmarshalStream(Tuple2<String, SendPort> args) async {
    initJson();
    args.item2.send(MetricReadingsStream.from(JsonMapper.deserialize<List<MetricReadingPoint>>(args.item1)));
  }
}

