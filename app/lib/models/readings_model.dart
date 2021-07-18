import 'dart:collection';
import 'dart:math';

import 'package:chainmetric/controllers/references_adapter.dart';
import 'package:chainmetric/models/metric_model.dart';
import 'package:chainmetric/models/requirements_model.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class MetricReadings {
  @JsonProperty(name: "asset_id")
  String assetID;
  @JsonProperty(name: "streams")
  Map<String, List<MetricReadingPoint>> streamsRaw;

  @JsonProperty(ignore: true)
  Map<Metric, MetricReadingsStream> get streams => References.metricsMap != null
      ? _streams ??= streamsRaw?.map((key, value) => MapEntry(
          References.metricsMap[key],
          MetricReadingsStream.from(streamsRaw[key])))
      : null;
  Map<Metric, MetricReadingsStream> _streams;
}

@jsonSerializable
class MetricReadingPoint {
  @JsonProperty(name: "device_id")
  String deviceID;
  String location;
  DateTime timestamp;
  num value;
  num get valueRounded => roundValue(value, 2);

  static num roundValue(num value, int places) {
    if (value is int) return value;
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}

class MetricReadingsStream extends ListBase<MetricReadingPoint> with MetricReadingPoint {
  List<MetricReadingPoint> _list = [];
  set length(int newLength) { _list.length = newLength; }
  int get length => _list.length;
  MetricReadingPoint operator [](int index) => _list[index];
  void operator []=(int index, MetricReadingPoint value) { _list[index] = value; }

  List<num> get _values => _list.map((p) => p.value).toList();

  num get firstValue => isNotEmpty
      ? MetricReadingPoint.roundValue(first.value, 2)
      : 0;

  num get lastValue => isNotEmpty
      ? MetricReadingPoint.roundValue(last.value, 2)
      : 0;

  num get maxValue => isNotEmpty
      ? MetricReadingPoint.roundValue(_values.reduce(max), 2)
      : 0;

  num get minValue => isNotEmpty
      ? MetricReadingPoint.roundValue(_values.reduce(min), 2)
      : 0;

  num get avgValue => isNotEmpty
      ? MetricReadingPoint.roundValue(_values.reduce((a, b) => a + b) / length, 2)
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



  bool _meetRequirement(num value, Requirement requirement) =>
      requirement.minLimit <= value && value <= requirement.maxLimit;
}
