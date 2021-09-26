import 'dart:math';

import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/infrastructure/repositories/devices_fabric.dart';
import 'package:chainmetric/infrastructure/repositories/readings_fabric.dart';
import 'package:chainmetric/models/assets/asset.dart';
import 'package:chainmetric/models/device/device.dart';
import 'package:chainmetric/models/readings/metric.dart';
import 'package:chainmetric/models/readings/readings.dart';
import 'package:chainmetric/models/assets/requirements.dart';
import 'package:chainmetric/shared/extensions.dart';
import 'package:chainmetric/app/utils/utils.dart';
import 'package:chainmetric/app/widgets/common/svg_icon.dart';
import 'package:charts_common/src/chart/common/canvas_shapes.dart'
    show CanvasBarStack, CanvasRect; // ignore: implementation_imports
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_element.dart'; // ignore: implementation_imports
import 'package:charts_flutter/src/text_style.dart'
    as style; // ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // ignore: implementation_imports

part 'readings_pageview.dart';

const defaultViewportPoints = 25;

class ReadingsPage extends StatefulWidget {
  final Asset? asset;
  final Requirements? requirements;
  final bool pageView;
  final int? pageIndex;
  final MetricReadings? readings;
  final List<Device>? devices;

  const ReadingsPage({
    this.asset,
    this.requirements,
    this.pageView = false,
    this.pageIndex,
    this.readings,
    this.devices,
  });

  @override
  State<ReadingsPage> createState() =>
      pageView ? _ReadingsPageViewState() : _ReadingsListViewState();
}

abstract class _ReadingsState extends State<ReadingsPage> {
  MetricReadings readings = MetricReadings();

  final viewportPoints = defaultViewportPoints;
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  Map<String?, Requirement?> get requirements => widget.requirements!.metrics;
  List<Device>? devicesCache;

  @override
  void initState() {
    super.initState();

    if (widget.readings != null) {
      readings = widget.readings!;
    } else {
      SchedulerBinding.instance!.addPostFrameCallback((_) => refreshData());
    }

    if (widget.devices != null) {
      devicesCache = widget.devices;
    } else {
      DevicesController.getDevices()
          .then((value) => setState(() => devicesCache = value));
    }
  }

  @protected
  Future refreshData() async {
    refreshKey.currentState?.show();
    return ReadingsController.getReadings(widget.asset!.id).then((value) {
      if (value != null) {
        setState(() => readings = value);
      }
    });
  }

  @protected
  List<charts.Series<MetricReadingPoint, DateTime>> fromReadingsStream(
      Metric metric, MetricReadingsStream stream) {
    return [
      charts.Series<MetricReadingPoint, DateTime>(
        id: metric.metric,
        displayName: metric.name,
        colorFn: (point, i) =>
            isCritical(stream, i!, requirements[metric.metric]!)
                ? charts.MaterialPalette.red.shadeDefault
                : charts.MaterialPalette.cyan.shadeDefault,
        domainFn: (point, _) => point.timestamp,
        measureFn: (point, _) => point.value,
        data: stream.toList(),
      )
    ];
  }

  @protected
  bool meetRequirement(num value, Requirement requirement) =>
      requirement.minLimit <= value && value <= requirement.maxLimit;

  @protected
  bool isCritical(
          MetricReadingsStream stream, int index, Requirement requirement) =>
      !meetRequirement(stream[index].value!, requirement) ||
      (index != stream.length - 1 &&
          !meetRequirement(stream[index + 1].value!, requirement));

  @protected
  charts.DateTimeExtents timeViewport(MetricReadingsStream stream) {
    var start = stream.last.timestamp
        .subtract(widget.requirements!.periodDuration * viewportPoints);

    if (start.isBefore(stream.first.timestamp)) {
      start = stream.first.timestamp;
    }

    return charts.DateTimeExtents(start: start, end: stream.last.timestamp);
  }

  @protected
  charts.NumericExtents measureViewport(MetricReadingsStream stream) {
    return charts.NumericExtents(((stream.minValue / 10).floor() * 10) - 10,
        ((stream.maxValue / 10).ceil() * 10) + 10);
  }
}

class _ReadingsListViewState extends _ReadingsState {
  @override
  int get viewportPoints => 50;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text("Metric readings",
            style: AppTheme.title2
                .override(fontFamily: "IBM Plex Mono", fontSize: 24)),
        centerTitle: false,
        elevation: 4,
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshData,
        child: _chartsListView(context),
      ));

  Widget _chartsListView(BuildContext context) => ListView.builder(
        itemCount: readings.streams?.length ?? 0,
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemBuilder: _listBuilder,
      );

  Widget _listBuilder(BuildContext context, int index) {
    final record = readings.streams!.entries.elementAt(index);
    return SafeArea(
      child: Hero(
        tag: record.key,
        child: InkWell(
          onTap: () => _openPage(index),
          child: _chartCard(record.key, record.value),
        ),
      ),
    );
  }

  Widget _chartCard(Metric metric, MetricReadingsStream stream) => Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Stack(
              children: [
                Positioned(left: 8, child: metric.icon()),
                Positioned.fill(
                  left: 40,
                  child: Text(metric.name,
                      style: const TextStyle(
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
                            style: const TextStyle(fontSize: 15)),
                        Text(metric.unit,
                            style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).hintColor)),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child:
                      SizedBox(height: 80, child: _buildChart(metric, stream)),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildChart(Metric metric, MetricReadingsStream stream) =>
      charts.TimeSeriesChart(
        fromReadingsStream(metric, stream),
        animate: true,
        primaryMeasureAxis: const charts.NumericAxisSpec(
            showAxisLine: false,
            renderSpec: charts.NoneRenderSpec(
                axisLineStyle: charts.LineStyleSpec(
                    color: charts.MaterialPalette.transparent))),
        domainAxis: charts.DateTimeAxisSpec(
            showAxisLine: false,
            viewport: timeViewport(stream),
            renderSpec: const charts.NoneRenderSpec(
                axisLineStyle: charts.LineStyleSpec(
                    color: charts.MaterialPalette.transparent))),
        defaultRenderer: charts.LineRendererConfig(
            includePoints: false,
            includeArea: true,
            roundEndCaps: true,
            areaOpacity: 0.1,
            strokeWidthPx: 2,
            radiusPx: 2),
        layoutConfig: charts.LayoutConfig(
          bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
          leftMarginSpec: charts.MarginSpec.fixedPixel(0),
          rightMarginSpec: charts.MarginSpec.fixedPixel(0),
          topMarginSpec: charts.MarginSpec.fixedPixel(20),
        ),
        behaviors: [
          charts.LinePointHighlighter(
            defaultRadiusPx: 0,
            showHorizontalFollowLine:
                charts.LinePointHighlighterFollowLineType.none,
            showVerticalFollowLine:
                charts.LinePointHighlighterFollowLineType.none,
          )
        ],
        selectionModels: [
          charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              changedListener: (_) =>
                  _openPage(readings.streams!.keys.toList().indexOf(metric)))
        ],
      );

  @override
  List<charts.Series<MetricReadingPoint, DateTime>> fromReadingsStream(
          Metric metric, MetricReadingsStream stream) =>
      [
        charts.Series<MetricReadingPoint, DateTime>(
          id: metric.metric,
          displayName: metric.name,
          colorFn: (point, i) =>
              isCritical(stream, i!, requirements[metric.metric]!)
                  ? charts.MaterialPalette.red.shadeDefault
                  : charts.MaterialPalette.cyan.shadeDefault,
          domainFn: (point, _) => point.timestamp,
          measureFn: (point, _) => point.value! <= 0 ? 0 : point.value,
          data: stream.toList(),
        )
      ];

  void _openPage(int index) => openPage(
      context,
      ReadingsPage(
        asset: widget.asset,
        requirements: widget.requirements,
        pageView: true,
        pageIndex: index,
        readings: readings,
        devices: devicesCache,
      ));
}

charts.Color toChartColor(Color color) =>
    charts.Color(r: color.red, g: color.green, b: color.blue, a: color.alpha);
