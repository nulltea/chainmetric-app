import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:chainmetric/models/readings/readings.dart';
import 'package:chainmetric/shared/logger.dart';
import 'package:flutter/services.dart';
import 'package:streams_channel2/streams_channel2.dart';
import 'package:talos/talos.dart';
import 'package:tuple/tuple.dart';

typedef ReadingsListener = void Function(MetricReadingPoint point);
typedef CancelReadingsListening = void Function();

class ReadingsController {

  static Future<MetricReadings?> getReadings(String assetID) async {
    try {
      final data = await Fabric.evaluateTransaction("readings", "ForAsset", assetID);
      if (data?.isEmpty ?? true) {
        return null;
      }
      final port = ReceivePort();
      Isolate.spawn(_unmarshalReadings, Tuple2(data!, port.sendPort));
      return await port.first as MetricReadings?;
    } on Exception catch (e) {
      logger.e("ReadingsController.getReadings: ${e.toString()}");
    }

    return null;
  }

  static Future<MetricReadingsStream?> getStream(
      String assetID, String metric) async {
    try {
      final data = await Fabric.evaluateTransaction("readings", "ForMetric",
          [assetID, metric]);
      if (data?.isEmpty ?? true) {
        return null;
      }
      final port = ReceivePort();
      Isolate.spawn(_unmarshalStream, Tuple2(data!, port.sendPort));
      return await port.first as MetricReadingsStream?;
    } on Exception catch (e) {
      logger.e("ReadingsController.getStream: ${e.toString()}");
    }

    return null;
  }

  static Future<CancelReadingsListening> subscribeToStream(
      String assetID, String metric, ReadingsListener listener) async {
    final cancel = EventSocket.bind((eventArtifact) {
      listener(MetricReadingPoint.fromJson(json.decode(eventArtifact)));
    }, "readings", [assetID, metric]);

    return cancel;
  }

  static Future<void> _unmarshalReadings(Tuple2<String, SendPort> args) async {
    args.item2.send(MetricReadings.fromJson(json.decode(args.item1)));
  }

  static Future<void> _unmarshalStream(Tuple2<String, SendPort> args) async {
    args.item2.send(MetricReadingsStream.from(
        MetricReadingPoint.listFromJson(json.decode(args.item1))));
  }
}
