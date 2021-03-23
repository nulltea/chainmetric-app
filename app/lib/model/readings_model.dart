import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class MetricReadings {
  @JsonProperty(name: "asset_id")
  String assetID;
  Map<String, List<MetricReadingPoint>> streams;
}

@jsonSerializable
class MetricReadingPoint {
  @JsonProperty(name: "device_id")
  String deviceID;
  String location;
  DateTime timestamp;
  num value;
}
