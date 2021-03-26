import 'dart:collection';
import 'dart:math';

import 'package:chainmetric/controllers/references_adapter.dart';
import 'package:chainmetric/model/metric_model.dart';
import 'package:chainmetric/model/requirements_model.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class MetricReadings {
  @JsonProperty(name: "asset_id")
  String assetID;
  @JsonProperty(name: "streams")
  Map<String, List<MetricReadingPoint>> streamsRaw;

  Map<Metric, MetricReadingsStream> get streams =>
      _streams ??= streamsRaw?.map((key, value) => MapEntry(
          References.metricsMap[key],
          MetricReadingsStream.from(streamsRaw[key])));
  Map<Metric, MetricReadingsStream> _streams;
}

@jsonSerializable
class MetricReadingPoint {
  @JsonProperty(name: "device_id")
  String deviceID;
  String location;
  DateTime timestamp;
  num value;
}

class MetricReadingsStream extends ListBase<MetricReadingPoint> with MetricReadingPoint {
  List<MetricReadingPoint> _list = [];
  set length(int newLength) { _list.length = newLength; }
  int get length => _list.length;
  MetricReadingPoint operator [](int index) => _list[index];
  void operator []=(int index, MetricReadingPoint value) { _list[index] = value; }

  List<num> get _values => _list.map((p) => p.value).toList();

  num get firstValue => isNotEmpty
      ? _roundDouble(first.value, 2)
      : 0;

  num get lastValue => isNotEmpty
      ? _roundDouble(last.value, 2)
      : 0;

  num get maxValue => isNotEmpty
      ? _roundDouble(_values.reduce(max), 2)
      : 0;

  num get minValue => isNotEmpty
      ? _roundDouble(_values.reduce(min), 2)
      : 0;

  num get avgValue => isNotEmpty
      ? _roundDouble(_values.reduce((a, b) => a + b) / length, 2)
      : 0;

  num complianceIndexFor(Requirement requirement) => isNotEmpty
      ? ((_values.where((p) => _meetRequirement(p, requirement)).length / length) * 100).round()
      : 100;

  Duration criticalExposureFor(Requirement requirement, Duration period) => isNotEmpty
      ? period * _values.where((p) => !_meetRequirement(p, requirement)).length
      : 0;

  MetricReadingsStream();
  MetricReadingsStream.from(List<MetricReadingPoint> from) {
    _list = from;
  }

  num _roundDouble(num value, int places) {
    if (value is int) return value;
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  bool _meetRequirement(num value, Requirement requirement) =>
      requirement.minLimit <= value && value <= requirement.maxLimit;
}
