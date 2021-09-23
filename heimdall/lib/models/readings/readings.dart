import 'dart:collection';
import 'dart:math';

import 'package:chainmetric/platform/repositories/localdata_json.dart';
import 'package:chainmetric/models/readings/metric.dart';
import 'package:chainmetric/models/assets/requirements.dart';
import 'package:json_annotation/json_annotation.dart';

part "readings.g.dart";

@JsonSerializable()
class MetricReadings {
  @JsonKey(name: "asset_id")
  String? assetID;
  @JsonKey(name: "streams")
  Map<String, List<MetricReadingPoint>>? streamsRaw;

  MetricReadings();

  @JsonKey(ignore: true)
  Map<Metric, MetricReadingsStream>? get streams =>
      _streams ??= streamsRaw?.map((key, value) => MapEntry(
          LocalDataRepo.metricsMap[key]!,
          MetricReadingsStream.from(streamsRaw![key])));
  Map<Metric, MetricReadingsStream>? _streams;

  factory MetricReadings.fromJson(Map<String, dynamic> json) =>
      _$MetricReadingsFromJson(json);

  Map<String, dynamic> toJson() => _$MetricReadingsToJson(this);
}

@JsonSerializable()
class MetricReadingPoint {
  @JsonKey(name: "device_id")
  late String deviceID;
  late String location;
  late DateTime timestamp;
  num? value;

  num get valueRounded => roundValue(value, 2);

  MetricReadingPoint();

  static num roundValue(num? value, int places) {
    if (value is int) return value;
    final mod = pow(10.0, places);
    return (value! * mod).round() / mod;
  }

  factory MetricReadingPoint.fromJson(Map<String, dynamic> json) =>
      _$MetricReadingPointFromJson(json);

  Map<String, dynamic> toJson() => _$MetricReadingPointToJson(this);

  static List<MetricReadingPoint> listFromJson(List<dynamic> json) =>
      json.map((e) => MetricReadingPoint.fromJson(e)).toList();
}

class MetricReadingsStream extends ListBase<MetricReadingPoint> {
  List<MetricReadingPoint>? _list = [];

  @override
  set length(int newLength) {
    _list!.length = newLength;
  }

  @override
  int get length => _list!.length;

  @override
  MetricReadingPoint operator [](int index) => _list![index];

  @override
  void operator []=(int index, MetricReadingPoint value) {
    _list![index] = value;
  }

  List<num> get _values => _list!.map((p) => p.value ?? 0).toList();

  num get firstValue =>
      isNotEmpty ? MetricReadingPoint.roundValue(first.value, 2) : 0;

  num get lastValue =>
      isNotEmpty ? MetricReadingPoint.roundValue(last.value, 2) : 0;

  num get maxValue =>
      isNotEmpty ? MetricReadingPoint.roundValue(_values.reduce(max), 2) : 0;

  num get minValue =>
      isNotEmpty ? MetricReadingPoint.roundValue(_values.reduce(min), 2) : 0;

  num get avgValue => isNotEmpty
      ? MetricReadingPoint.roundValue(
          _values.reduce((a, b) => a + b) / length, 2)
      : 0;

  num complianceIndexFor(Requirement? requirement) => isNotEmpty
      ? ((_values.where((p) => _meetRequirement(p, requirement!)).length /
                  length) *
              100)
          .round()
      : 100;

  Duration criticalExposureFor(Requirement? requirement, Duration period) =>
      Duration(
          seconds: isNotEmpty
              ? period.inSeconds *
                  _values
                      .where((p) => !_meetRequirement(p, requirement!))
                      .length
              : 0);

  MetricReadingsStream();

  MetricReadingsStream.from(List<MetricReadingPoint>? from) {
    _list = from;
  }

  bool _meetRequirement(num value, Requirement requirement) =>
      requirement.minLimit <= value && value <= requirement.maxLimit;
}
