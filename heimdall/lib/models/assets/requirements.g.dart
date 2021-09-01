// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requirements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Requirement _$RequirementFromJson(Map<String, dynamic> json) {
  return Requirement()
    ..minLimit = json['min_limit'] as num
    ..maxLimit = json['max_limit'] as num;
}

Map<String, dynamic> _$RequirementToJson(Requirement instance) =>
    <String, dynamic>{
      'min_limit': instance.minLimit,
      'max_limit': instance.maxLimit,
    };

Requirements _$RequirementsFromJson(Map<String, dynamic> json) {
  return Requirements()
    ..id = json['id'] as String
    ..type = json['type'] as String?
    ..assetID = json['asset_id'] as String?
    ..period = json['period'] as int?
    ..metrics = (json['metrics'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k,
          e == null ? null : Requirement.fromJson(e as Map<String, dynamic>)),
    );
}

Map<String, dynamic> _$RequirementsToJson(Requirements instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'asset_id': instance.assetID,
      'period': instance.period,
      'metrics': instance.metrics.map((k, e) => MapEntry(k, e?.toJson())),
    };
