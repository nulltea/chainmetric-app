import 'package:chainmetric/model/asset_model.dart';
import 'package:chainmetric/model/requirements_model.dart';
import 'package:chainmetric/shared/utils.dart';
import 'package:flutter/cupertino.dart';
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

  final _refreshKey = GlobalKey<RefreshIndicatorState>();
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
  Widget buildChart(Metric metric, MetricReadingsStream stream) => charts.TimeSeriesChart(_fromReadingsStream(metric, stream),
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
                color: toChartColor(Theme.of(context).hintColor),
              ),
              labelAnchor: charts.AnnotationLabelAnchor.end,
              color: charts.Color(r: 12, g: 110, b: 76, a: 100)),
        ], defaultLabelPosition: charts.AnnotationLabelPosition.auto),
      ]
  );

  @protected
  Future refreshData() {
    _refreshKey.currentState?.show();
    return ReadingsController.getReadings(widget.asset.id).then((value) =>
        setState(() => readings = value)
    );
  }

  List<charts.Series<MetricReadingPoint, DateTime>> _fromReadingsStream(Metric metric, MetricReadingsStream stream) {
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
    var start = stream.last.timestamp.subtract(widget.requirements.periodDuration * VIEWPORT_POINTS);
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
  Widget build(context) => Scaffold(
      appBar: AppBar(
        title: Text("Metric readings"),
      ),
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: refreshData,
        child: _chartsListView(context),
      ));


  Widget _chartsListView(BuildContext context) => ListView.builder(
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
          onLongPress: () => print("onLongPress"),
          onTap: () => openPage(context, ReadingsPage(
            asset: widget.asset,
            requirements: widget.requirements,
            pageView: true,
            pageIndex: index,
            readings: readings,
          )),
        ),
      ),
    );
  }

  Widget _chartCard(Metric metric, MetricReadingsStream stream) => Card(
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
                child: buildChart(metric, stream),
              ),
            ],
          )
      ),
    ),
  );
}

class _ReadingsPageViewState extends _ReadingsState {
  int currentPage;

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
      viewportFraction: 0.93,
    ),
    itemCount: readings.streams?.length ?? 0,
    itemBuilder: _pagerBuilder,
    onPageChanged: (i) => setState(() => currentPage = i),
  );

  Widget _pagerBuilder(BuildContext context, int index) {
    var record = readings.streams.entries.elementAt(index);
    return SafeArea(
      child: _chartPage(record.key, record.value),
    );
  }

  Widget _chartPage(Metric metric, MetricReadingsStream stream) => Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
              height: 300,
              child: buildChart(metric, stream)
          ),
          Align(alignment: Alignment.centerLeft,child: Text("Statistics", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600))),
          ListTile(leading: Icon(Icons.trending_up), title: Text("Max value"), trailing: Text("${stream.maxValue} ${metric.unit}")),
          ListTile(leading: Icon(Icons.trending_down), title: Text("Min value"), trailing: Text("${stream.minValue} ${metric.unit}")),
          ListTile(leading: Icon(Icons.functions), title: Text("Average value"), trailing: Text("${stream.avgValue} ${metric.unit}")),
          ListTile(leading: Icon(Icons.rule), title: Text("Compliance index"), trailing: Text("${stream.complianceIndexFor(widget.requirements.metrics[metric.metric])}%")),
        ],
      ),
    ),
  );

  String _currentPageTitle() =>
      readings.streams.entries.elementAt(currentPage ?? widget.pageIndex).key.name;
}
