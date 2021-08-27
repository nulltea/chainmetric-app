// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'readings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetricReadings _$MetricReadingsFromJson(Map<String, dynamic> json) {
  return MetricReadings()
    ..assetID = json['asset_id'] as String?
    ..streamsRaw = (json['streams'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(
          k,
          (e as List<dynamic>)
              .map((e) => e == null
                  ? null
                  : MetricReadingPoint.fromJson(e as Map<String, dynamic>))
              .toList()),
    );
}

Map<String, dynamic> _$MetricReadingsToJson(MetricReadings instance) =>
    <String, dynamic>{
      'asset_id': instance.assetID,
      'streams': instance.streamsRaw
          ?.map((k, e) => MapEntry(k, e.map((e) => e?.toJson()).toList())),
    };

MetricReadingPoint _$MetricReadingPointFromJson(Map<String, dynamic> json) {
  return MetricReadingPoint()
    ..deviceID = json['device_id'] as String
    ..location = json['location'] as String
    ..timestamp = DateTime.parse(json['timestamp'] as String)
    ..value = json['value'] as num?;
}

Map<String, dynamic> _$MetricReadingPointToJson(MetricReadingPoint instance) =>
    <String, dynamic>{
      'device_id': instance.deviceID,
      'location': instance.location,
      'timestamp': instance.timestamp.toIso8601String(),
      'value': instance.value,
    };
