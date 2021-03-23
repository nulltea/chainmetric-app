import 'package:chainmetric/model/readings_model.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'blockchain_adapter.dart';

class ReadingsController {
  static Future<MetricReadings> getReadings(String assetID) async {
    String data = await Blockchain.evaluateTransaction("readings", "ForAsset", assetID);
    try {
      return data.isNotEmpty ? JsonMapper.deserialize<MetricReadings>(data) : null;
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }
}
