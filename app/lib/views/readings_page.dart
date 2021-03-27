import 'dart:math';

import 'package:chainmetric/model/asset_model.dart';
import 'package:chainmetric/model/requirements_model.dart';
import 'package:chainmetric/shared/utils.dart';
import 'package:chainmetric/shared/extensions.dart';
import 'package:chainmetric/views/components/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:chainmetric/controllers/readings_controller.dart';
import 'package:chainmetric/model/metric_model.dart';
import 'package:chainmetric/model/readings_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

const VIEWPORT_POINTS = 25;

class ReadingsPage extends StatefulWidget {
  final Asset asset;
  final Requirements requirements;
  final bool pageView;
  final int pageIndex;
  final MetricReadings readings;

  ReadingsPage({
    this.asset,
    this.requirements,
    this.pageView = false,
    this.pageIndex,
    this.readings,
  });

  @override
  State<ReadingsPage> createState() => pageView
      ? _ReadingsPageViewState()
      : _ReadingsListViewState();
}

abstract class _ReadingsState extends State<ReadingsPage> {
  MetricReadings readings = MetricReadings();

  final viewportPoints = VIEWPORT_POINTS;
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  get requirements => widget.requirements.metrics;

  @override
  void initState() {
    super.initState();
    if (widget.readings != null) {
      this.readings = widget.readings;
      return;
    }
    refreshData();
  }

  @protected
  Future refreshData() {
    refreshKey.currentState?.show();
    return ReadingsController.getReadings(widget.asset.id).then((value) =>
        setState(() => readings = value)
    );
  }

  @protected
  List<charts.Series<MetricReadingPoint, DateTime>> fromReadingsStream(Metric metric, MetricReadingsStream stream) {
    return [
      charts.Series<MetricReadingPoint, DateTime>(
        id: metric.metric,
        displayName: metric.name,
        colorFn: (point, _) => meetRequirement(point.value, requirements[metric.metric])
            ? charts.MaterialPalette.cyan.shadeDefault
            : charts.MaterialPalette.red.shadeDefault,
        domainFn: (point, _) => point.timestamp,
        measureFn: (point, _) => point.value,
        data: stream,
      )
    ];
  }

  @protected
  bool meetRequirement(num value, Requirement requirement) =>
      requirement.minLimit <= value && value <= requirement.maxLimit;

  @protected
  charts.DateTimeExtents timeViewport(MetricReadingsStream stream) {
    var start = stream.last.timestamp.subtract(widget.requirements.periodDuration * viewportPoints);
    if (start.isBefore(stream.first.timestamp)) start = stream.first.timestamp;
    return charts.DateTimeExtents(
        start: start,
        end: stream.last.timestamp
    );
  }

  @protected
  charts.Color toChartColor(Color color) =>
      charts.Color(r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _ReadingsListViewState extends _ReadingsState {
  @override
  int get viewportPoints => 50;

  @override
  Widget build(context) =>
      Scaffold(
          appBar: AppBar(
            title: Text("Metric readings"),
          ),
          body: RefreshIndicator(
            key: refreshKey,
            onRefresh: refreshData,
            child: _chartsListView(context),
          ));


  Widget _chartsListView(BuildContext context) =>
      ListView.builder(
        itemCount: readings.streams?.length ?? 0,
        padding: EdgeInsets.symmetric(vertical: 12),
        itemBuilder: _listBuilder,
      );

  Widget _listBuilder(BuildContext context, int index) {
    var record = readings.streams.entries.elementAt(index);
    return SafeArea(
      child: Hero(
        tag: record.key,
        child: InkWell(
          child: _chartCard(record.key, record.value),
          onTap: () => _openPage(index),
        ),
      ),
    );
  }

  Widget _chartCard(Metric metric, MetricReadingsStream stream) => Card(
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
          height: 100,
          child: Stack(
            children: [
              Positioned(
                  left: 8,
                  child: metric.icon()
              ),
              Positioned.fill(
                left: 40,
                child: Text(metric.name, style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              Positioned(
                right: 8,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("${stream.lastValue}",
                          style: TextStyle(fontSize: 15)
                      ),
                      Text(metric.unit,
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).hintColor
                          )
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 80,
                    child: _buildChart(metric, stream)
                ),
              ),
            ],
          )
      ),
    ),
  );

  Widget _buildChart(Metric metric, MetricReadingsStream stream) => charts.TimeSeriesChart(fromReadingsStream(metric, stream),
      animate: true,
      primaryMeasureAxis: charts.NumericAxisSpec(
          showAxisLine: false,
          renderSpec: charts.NoneRenderSpec(
              axisLineStyle: charts.LineStyleSpec(
                  color: charts.MaterialPalette.transparent
              )
          )
      ),
      domainAxis: charts.DateTimeAxisSpec(
          showAxisLine: false,
          viewport: timeViewport(stream),
          renderSpec: charts.NoneRenderSpec(
              axisLineStyle: charts.LineStyleSpec(
                  color: charts.MaterialPalette.transparent
              )
          )
      ),
      defaultRenderer: charts.LineRendererConfig(
        includePoints: false,
        includeArea: true,
        roundEndCaps: true,
        areaOpacity: 0.1,
        strokeWidthPx: 2,
        radiusPx: 2
      ),
    layoutConfig: charts.LayoutConfig(
      bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
      leftMarginSpec: charts.MarginSpec.fixedPixel(0),
      rightMarginSpec: charts.MarginSpec.fixedPixel(0),
      topMarginSpec: charts.MarginSpec.fixedPixel(20),
    ),
    behaviors: [
      charts.LinePointHighlighter(
        defaultRadiusPx: 0,
        showHorizontalFollowLine: charts.LinePointHighlighterFollowLineType.none,
        showVerticalFollowLine: charts.LinePointHighlighterFollowLineType.none,
      )
    ],
    selectionModels: [
      charts.SelectionModelConfig(
        type: charts.SelectionModelType.info,
        changedListener: (_) => _openPage(readings.streams.keys.toList().indexOf(metric))
      )
    ],
  );

  @override
  List<charts.Series<MetricReadingPoint, DateTime>> fromReadingsStream(
      Metric metric,
      MetricReadingsStream stream) => [
      charts.Series<MetricReadingPoint, DateTime>(
        id: metric.metric,
        displayName: metric.name,
        colorFn: (point, _) => meetRequirement(point.value, requirements[metric.metric])
            ? charts.MaterialPalette.cyan.shadeDefault
            : charts.MaterialPalette.red.shadeDefault,
        domainFn: (point, _) => point.timestamp,
        measureFn: (point, _) => point.value <= 0 ? 0: point.value,
        data: stream,
      )
    ];

  void _openPage(int index) => openPage(context, ReadingsPage(
    asset: widget.asset,
    requirements: widget.requirements,
    pageView: true,
    pageIndex: index,
    readings: readings,
  ));
}

class _ReadingsPageViewState extends _ReadingsState {
  int currentPage;
  bool scrollLocked = false;

  @override
  Widget build(context) => Scaffold(
    appBar: AppBar(
      title: Text(_currentPageTitle()),
      centerTitle: true,
      toolbarHeight: 50,
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop()
      ),
    ),
    body: _chartsPageView(context)
  );

  Widget _chartsPageView(BuildContext context) => PageView.builder(
    controller: PageController(
      initialPage: widget.pageIndex,
      viewportFraction: 0.93
    ),
    itemCount: readings.streams?.length ?? 0,
    itemBuilder: _pagerBuilder,
    onPageChanged: (i) => setState(() => currentPage = i),
      physics: scrollLocked ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics()
  );

  Widget _pagerBuilder(BuildContext context, int index) {
    var record = readings.streams.entries.elementAt(index);
    return SafeArea(
      child: _chartPage(record.key, record.value),
    );
  }

  Widget _chartPage(Metric metric, MetricReadingsStream stream) => GestureDetector(
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(_isActiveStream(metric)
                    ? "Monitoring now"
                    : "Monitoring stopped",
                    style: TextStyle(color: Theme.of(context).hintColor)
                ),
                SizedBox(width: 5),
                Icon(Icons.circle, color: _isActiveStream(metric)
                    ? Colors.green.withAlpha(200)
                    : Colors.red.withAlpha(200))
              ],
            ),
            SizedBox(
                height: 300,
                child: _buildChart(metric, stream)),
            SizedBox(height: 10),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Statistics",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)
                )
            ),
            ListTile(
                leading: Icon(Icons.trending_up),
                title: Text("Max value"),
                trailing: Text("${stream.maxValue}${metric.unit}")
            ),
            ListTile(
                leading: Icon(Icons.trending_down),
                title: Text("Min value"),
                trailing: Text("${stream.minValue}${metric.unit}")
            ),
            ListTile(
                leading: Icon(Icons.functions),
                title: Text("Average value"),
                trailing: Text("${stream.avgValue}${metric.unit}")
            ),
            ListTile(
                leading: Icon(Icons.rule),
                title: Text("Compliance index"),
                trailing: Text("${stream.complianceIndexFor(widget.requirements.metrics[metric.metric])}%")
            ),
            ListTile(
                leading: SvgIcon("running_with_errors"),
                title: Text("Critical exposure duration"),
                trailing: Text(stream.criticalExposureFor(widget.requirements.metrics[metric.metric], widget.requirements.periodDuration).toShortString())
            ),
          ],
        ),
      ),
    ),
    onTapDown:(v) => setState(() {
      if (v.localPosition.dy < 350) {
        scrollLocked = true;
      } else {
        scrollLocked = false;
      }
    }),
  );

  Widget _buildChart(Metric metric, MetricReadingsStream stream) => charts.TimeSeriesChart(fromReadingsStream(metric, stream),
      animate: true,
      primaryMeasureAxis: charts.NumericAxisSpec(
          showAxisLine: false,
          renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(
              fontSize: 10,
              color: toChartColor(Theme.of(context).hintColor),
            ),
            lineStyle: charts.LineStyleSpec(
              thickness: 0,
              color: toChartColor(Theme.of(context).hintColor),
            ),
          ),
          tickFormatterSpec: charts.BasicNumericTickFormatterSpec((v) => "$v${metric.unit}")
      ),
      domainAxis: charts.DateTimeAxisSpec(
          showAxisLine: false,
          viewport: timeViewport(stream),
          renderSpec: charts.GridlineRendererSpec(
              labelStyle: charts.TextStyleSpec(
                fontSize: 10,
                color: toChartColor(Theme.of(context).hintColor),
              ),
              lineStyle: charts.LineStyleSpec(
                thickness: 0,
                color: toChartColor(Theme.of(context).hintColor),
              )
          )
      ),
      defaultRenderer: charts.LineRendererConfig(
        includePoints: true,
        includeArea: true,
        areaOpacity: 0.1,
        strokeWidthPx: 2,
        radiusPx: 3,
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
                color: toChartColor(Theme.of(context).hintColor),
              ),
              labelAnchor: charts.AnnotationLabelAnchor.end,
              color: charts.Color(r: 12, g: 110, b: 76, a: 100)),
        ], defaultLabelPosition: charts.AnnotationLabelPosition.auto),
      ]
  );

  bool _isActiveStream(Metric metric) => DateTime.now().difference(readings.streams[metric].last.timestamp).inSeconds < widget.requirements.period * 3;

  String _currentPageTitle() =>
      readings.streams.entries.elementAt(currentPage ?? widget.pageIndex).key.name;
}
