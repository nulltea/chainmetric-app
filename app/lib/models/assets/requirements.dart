import 'package:json_annotation/json_annotation.dart';

part "requirements.g.dart";

@JsonSerializable()
class Requirement {
  @JsonKey(name: "min_limit")
  late num minLimit;
  @JsonKey(name: "max_limit")
  late num maxLimit;

  Requirement();

  factory Requirement.fromJson(Map<String, dynamic> json) => _$RequirementFromJson(json);
  Map<String, dynamic> toJson() => _$RequirementToJson(this);
}

@JsonSerializable()
class Requirements {
  late final String id;
  String? type;
  @JsonKey(name: "asset_id")
  String? assetID;
  int? period;
  Duration get periodDuration => Duration(seconds: period ?? 0);
  Map<String, Requirement?> metrics = <String, Requirement?>{};

  Requirements();
  Requirements.forAsset({this.assetID});

  factory Requirements.fromJson(Map<String, dynamic> json) => _$RequirementsFromJson(json);
  Map<String, dynamic> toJson() => _$RequirementsToJson(this);
}