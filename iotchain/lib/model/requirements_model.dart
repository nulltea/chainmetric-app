import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class Requirement {
  @JsonProperty(name: "min_limit")
  num minLimit;
  @JsonProperty(name: "max_limit")
  num maxLimit;
}

@jsonSerializable
class Requirements {
  String id;
  String type;
  @JsonProperty(name: "asset_id")
  String assetID;
  Map<String, Requirement> metrics = Map<String, Requirement>();
}