// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Metric _$MetricFromJson(Map<String, dynamic> json) {
  return Metric()
    ..name = json['name'] as String
    ..metric = json['metric'] as String
    ..unit = json['unit'] as String
    ..iconName = json['icon'] as String?
    ..iconType = json['icon_type'] as String?;
}

Map<String, dynamic> _$MetricToJson(Metric instance) => <String, dynamic>{
      'name': instance.name,
      'metric': instance.metric,
      'unit': instance.unit,
      'icon': instance.iconName,
      'icon_type': instance.iconType,
    };
