import 'dart:math';

import 'package:chainmetric/model/asset_model.dart';
import 'package:chainmetric/model/requirements_model.dart';
import 'package:flutter/material.dart';
import 'package:chainmetric/controllers/readings_controller.dart';
import 'package:chainmetric/controllers/references_adapter.dart';
import 'package:chainmetric/model/metric_model.dart';
import 'package:chainmetric/model/readings_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

const VIEWPORT_POINTS = 25;

class ReadingsPage extends StatefulWidget {
  final Asset asset;
  final Requirements requirements;

  ReadingsPage({this.asset, this.requirements});

  @override
  _ReadingsPageState createState() => _ReadingsPageState();
}

class _ReadingsPageState extends State<ReadingsPage> {
  MetricReadings readings = MetricReadings();

  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  get requirements => widget.requirements.metrics;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(
        title: Text("Metric readings"),
      ),
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: _refreshData,
        child: ListView.builder(
          itemCount: readings.streams?.length ?? 0,
          padding: EdgeInsets.symmetric(vertical: 12),
          itemBuilder: _listBuilder,
        ),
      ));

  Widget _listBuilder(BuildContext context, int index) {
    var record = readings.streams.entries.elementAt(index);
    var metric = References.metricsMap[record.key];
    return InkWell(
      child: _streamChart(metric, record.value),
      onLongPress: () => print("onLongPress"),
    );
  }

  Widget _streamChart(Metric metric, List<MetricReadingPoint> stream) => Card(
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 150,
        child: Stack(
          children: [
            Text(metric.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            Positioned.fill(
              top: 30,
              child: charts.TimeSeriesChart(_fromReadingsStream(metric, stream),
                animate: true,
                primaryMeasureAxis: charts.NumericAxisSpec(
                    showAxisLine: false,
                    renderSpec: charts.GridlineRendererSpec(
                        labelStyle: charts.TextStyleSpec(
                            fontSize: 10,
                            color: _toChartColor(Theme.of(context).hintColor),
                        ),
                        lineStyle: charts.LineStyleSpec(
                            thickness: 0,
                            color: _toChartColor(Theme.of(context).hintColor),
                        ),
                    ),
                  tickFormatterSpec: charts.BasicNumericTickFormatterSpec((v) => "$v${metric.unit}")
                ),
                domainAxis: charts.DateTimeAxisSpec(
                    showAxisLine: false,
                    viewport: _timeViewport(stream),
                    renderSpec: charts.GridlineRendererSpec(
                        labelStyle: charts.TextStyleSpec(
                            fontSize: 10,
                            color: _toChartColor(Theme.of(context).hintColor),
                        ),
                        lineStyle: charts.LineStyleSpec(
                            thickness: 0,
                            color: _toChartColor(Theme.of(context).hintColor),
                        )
                    )
                ),

                defaultRenderer: charts.LineRendererConfig(
                  includePoints: true,
                  includeArea: true,
                  areaOpacity: 0.1,
                  strokeWidthPx: 2,
                  radiusPx: 4,
                  roundEndCaps: true,
                ),
                behaviors: [
                  charts.PanAndZoomBehavior(),
                  charts.SlidingViewport(),
                  charts.SelectNearest(),
                  charts.DomainHighlighter(),
                  charts.RangeAnnotation([
                    charts.RangeAnnotationSegment(
                        requirements[metric.metric].minLimit,
                        requirements[metric.metric].maxLimit,
                        charts.RangeAnnotationAxisType.measure,
                        startLabel: "Min (${requirements[metric.metric].minLimit}${metric.unit})",
                        endLabel: "Max (${requirements[metric.metric].maxLimit}${metric.unit})",
                        labelStyleSpec: charts.TextStyleSpec(
                          color: _toChartColor(Theme.of(context).hintColor),
                        ),
                        labelAnchor: charts.AnnotationLabelAnchor.end,
                        color: charts.Color(r: 12, g: 110, b: 76, a: 100)),
                  ], defaultLabelPosition: charts.AnnotationLabelPosition.auto),
                ]
              ),
            ),
          ],
        )
      ),
    ),
  );


  Future _refreshData() {
    _refreshKey.currentState?.show();
    return ReadingsController.getReadings(widget.asset.id).then((value) =>
        setState(() => readings = value)
    );
  }

  List<charts.Series<MetricReadingPoint, DateTime>> _fromReadingsStream(Metric metric, List<MetricReadingPoint> stream) {
    return [
      charts.Series<MetricReadingPoint, DateTime>(
        id: metric.metric,
        displayName: metric.name,
        colorFn: (point, _) => _meetRequirement(point.value, requirements[metric.metric])
            ? charts.MaterialPalette.cyan.shadeDefault
            : charts.MaterialPalette.red.shadeDefault,
        domainFn: (point, _) => point.timestamp,
        measureFn: (point, _) => point.value,
        data: stream,
      )
    ];
  }

  bool _meetRequirement(num value, Requirement requirement) =>
      requirement.minLimit <= value && value <= requirement.maxLimit;

  charts.DateTimeExtents _timeViewport(List<MetricReadingPoint> stream) {
    var start = stream.last.timestamp.subtract(widget.requirements.periodDuration * VIEWPORT_POINTS);
    if (start.isBefore(stream.first.timestamp)) start = stream.first.timestamp;
    return charts.DateTimeExtents(
          start: start,
          end: stream.last.timestamp
      );
  }

  charts.Color _toChartColor(Color color) =>
      charts.Color(r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
