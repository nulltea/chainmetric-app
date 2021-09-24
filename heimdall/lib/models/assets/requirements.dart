import 'package:json_annotation/json_annotation.dart';

part "requirements.g.dart";

@JsonSerializable()
class Requirement {
  @JsonKey(name: "min_limit")
  late num minLimit;
  @JsonKey(name: "max_limit")
  late num maxLimit;

  Requirement();

  factory Requirement.fromJson(Map<String, dynamic> json) =>
      _$RequirementFromJson(json);
  Map<String, dynamic> toJson() => _$RequirementToJson(this);

  static Map<String, Requirement> mapFromJson(Map<String, dynamic> json) =>
      json.map((key, value) => MapEntry(key, Requirement.fromJson(value)));
}

@JsonSerializable()
class Requirements {
  late final String id;
  @JsonKey(name: "asset_id")
  late final String assetID;
  @JsonKey(name: "from_org")
  late String fromOrg;
  int? period;
  Duration get periodDuration => Duration(seconds: period ?? 0);
  Map<String, Requirement?> metrics = <String, Requirement?>{};

  Requirements();
  Requirements.forAsset(this.assetID, {this.id="", this.period=120, this.fromOrg=""});

  factory Requirements.fromJson(Map<String, dynamic> json) =>
      _$RequirementsFromJson(json);
  Map<String, dynamic> toJson() => _$RequirementsToJson(this);
}
