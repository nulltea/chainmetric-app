import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class Requirement {
  @JsonProperty(name: "min_limit")
  late num minLimit;
  @JsonProperty(name: "max_limit")
  late num maxLimit;
}

@jsonSerializable
class Requirements {
  String? id;
  String? type;
  @JsonProperty(name: "asset_id")
  String? assetID;
  int? period;
  Duration get periodDuration => Duration(seconds: period ?? 0);
  Map<String?, Requirement?> metrics = <String?, Requirement?>{};

  Requirements();
  Requirements.forAsset({this.assetID});
}