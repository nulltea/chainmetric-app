part of 'readings_page.dart';

class _ReadingsPageViewState extends _ReadingsState {
  int? currentPage;
  bool scrollLocked = false;
  bool animate = true;
  late Map<Metric?, CancelReadingsListening> streamListeners;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    streamListeners = <Metric?, CancelReadingsListening>{};
    _onPageChanged(widget.pageIndex!);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(_currentPageTitle()!),
      centerTitle: true,
      toolbarHeight: 50,
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop()),
    ),
    body: _chartsPageView(context),
    bottomNavigationBar: SizedBox(
      height: 25,
      child: Align(
        alignment: Alignment.topCenter,
        child: SmoothPageIndicator(
            controller: _controller,
            count: readings.streams?.length ?? 0,
            effect: ExpandingDotsEffect(
              dotColor: Theme.of(context).cardColor,
              activeDotColor: Theme.of(context).primaryColor,
              dotHeight: 14,
              dotWidth: 14,
            )),
      ),
    ),
  );

  @override
  void dispose() {
    super.dispose();
    streamListeners.forEach((_, cancel) => cancel());
  }

  Widget _chartsPageView(BuildContext context) => PageView.builder(
    controller: _controller = PageController(
        initialPage: widget.pageIndex!, viewportFraction: 0.93),
    itemCount: readings.streams?.length ?? 0,
    itemBuilder: _pagerBuilder,
    onPageChanged: _onPageChanged,
    physics: scrollLocked
        ? const NeverScrollableScrollPhysics()
        : const AlwaysScrollableScrollPhysics(),
  );

  Widget _pagerBuilder(BuildContext context, int index) {
    final record = readings.streams!.entries.elementAt(index);
    return _chartPage(record.key, record.value);
  }

  Widget _chartPage(Metric metric, MetricReadingsStream stream) =>
      GestureDetector(
        onTapDown: (v) => setState(() {
          animate = false;
          if (v.localPosition.dy < 350) {
            scrollLocked = true;
          } else {
            scrollLocked = false;
          }
        }),
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.only(left: 4, right: 4, bottom: 12),
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
                    Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            metric.icon(
                                size: 26,
                                color: meetRequirement(stream.lastValue,
                                    requirements[metric.metric]!)
                                    ? Colors.green
                                    : Colors.red),
                            const SizedBox(width: 5),
                            Text("${stream.lastValue}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: meetRequirement(stream.lastValue,
                                        requirements[metric.metric]!)
                                        ? Colors.green
                                        : Colors.red)),
                            Text(metric.unit,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: meetRequirement(stream.lastValue,
                                        requirements[metric.metric]!)
                                        ? Colors.green.withAlpha(160)
                                        : Colors.red.withAlpha(160))),
                          ],
                        )),
                    const Spacer(),
                    Text(
                        _isActiveStream(metric)
                            ? "Monitoring now"
                            : "Last updated \n${stream.last.timestamp.timeAgoSinceDate()}",
                        style: TextStyle(color: Theme.of(context).hintColor)),
                    if (_isActiveStream(metric)) ...{
                      const SizedBox(width: 5),
                      Icon(Icons.circle, color: Colors.green.withAlpha(160))
                    }
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(height: 300, child: _buildChart(metric, stream)),
                const SizedBox(height: 15),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Statistics",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600))),
                ListTile(
                    leading: const Icon(Icons.trending_up),
                    title: const Text("Highest value"),
                    trailing: Text("${stream.maxValue}${metric.unit}")),
                ListTile(
                    leading: const Icon(Icons.trending_down),
                    title: const Text("Lowest value"),
                    trailing: Text("${stream.minValue}${metric.unit}")),
                ListTile(
                    leading: const Icon(Icons.functions),
                    title: const Text("Average value"),
                    trailing: Text("${stream.avgValue}${metric.unit}")),
                ListTile(
                    leading: const Icon(Icons.rule),
                    title: const Text("Compliance index"),
                    trailing: Text(
                        "${stream.complianceIndexFor(widget.requirements!.metrics[metric.metric])}%")),
                ListTile(
                    leading: const SvgIcon("running_with_errors"),
                    title: const Text("Critical exposure duration"),
                    trailing: Text(stream
                        .criticalExposureFor(
                        widget.requirements!.metrics[metric.metric],
                        widget.requirements!.periodDuration)
                        .toShortString())),
              ],
            ),
          ),
        ),
      );

  Widget _buildChart(Metric metric, MetricReadingsStream stream) =>
      charts.TimeSeriesChart(
        fromReadingsStream(metric, stream),
        animate: animate,
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
            tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                    (v) => "$v${metric.unit}")),
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
                ))),
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
          charts.LinePointHighlighter(
            symbolRenderer: WithTooltipSymbolRenderer(context, metric,
                devices: devicesCache),
          ),
          charts.RangeAnnotation([
            charts.RangeAnnotationSegment(
                max(requirements[metric.metric]!.minLimit,
                    measureViewport(stream).min),
                min(requirements[metric.metric]!.maxLimit,
                    measureViewport(stream).max),
                charts.RangeAnnotationAxisType.measure,
                startLabel:
                "Min (${requirements[metric.metric]!.minLimit}${metric.unit})",
                endLabel:
                "Max (${requirements[metric.metric]!.maxLimit}${metric.unit})",
                labelStyleSpec: charts.TextStyleSpec(
                  color: toChartColor(Theme.of(context).hintColor),
                ),
                labelAnchor: charts.AnnotationLabelAnchor.end,
                color: const charts.Color(r: 12, g: 110, b: 76, a: 100)),
          ], defaultLabelPosition: charts.AnnotationLabelPosition.auto),
        ],
        selectionModels: [
          charts.SelectionModelConfig(changedListener: (model) {
            if (model.hasDatumSelection) {
              WithTooltipSymbolRenderer.point =
              stream[model.selectedDatum[0].index!];
            }
          })
        ],
      );

  void _onPageChanged(int page) {
    final metric = readings.streams!.entries.elementAt(page).key;

    // Updating current page for displaying metric name as title
    setStateWithAnimate(() => currentPage = page);

    if (!streamListeners.containsKey(metric)) {
      ReadingsController.getStream(widget.asset!.id, metric.metric)
          .then((value) => setStateWithAnimate(() {
        readings.streams![metric] = value!;
      }, animate: false));

      ReadingsController.subscribeToStream(widget.asset!.id, metric.metric,
              (point) {
            setStateWithAnimate(() {
              readings.streams![metric]!.add(point);
            }, animate: false);
          }).then((cancel) => streamListeners[metric] = cancel);
    }
  }

  void setStateWithAnimate(void Function() setter, {bool animate = true}) =>
      setState(() {
        this.animate = animate;
        setter();
      });

  bool _isActiveStream(Metric metric) {
    if (readings.streams?.containsKey(metric) ?? false) return false;

    final lastUpdated = readings.streams![metric]!.last.timestamp;
    return DateTime.now().difference(lastUpdated).inSeconds <
        max(widget.requirements!.period! * 3, 60);
  }

  String? _currentPageTitle() => readings.streams!.entries
      .elementAt(currentPage ?? widget.pageIndex!)
      .key
      .name;
}

class WithTooltipSymbolRenderer extends charts.CircleSymbolRenderer {
  static MetricReadingPoint? point;
  final Metric metric;
  final BuildContext context;
  final Map<String?, Device> devicesMap;

  WithTooltipSymbolRenderer(this.context, this.metric, {List<Device>? devices})
      : devicesMap = {for (var d in devices ?? <Device>[]) d.id: d};

  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
      {List<int>? dashPattern,
        charts.Color? fillColor,
        charts.FillPatternType? fillPattern,
        charts.Color? strokeColor,
        double? strokeWidthPx}) {
    if (point == null) return;
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);
    canvas.drawBarStack(CanvasBarStack([
      CanvasRect(
          Rectangle(bounds.left.round() - 80, bounds.top.round() + 30,
              bounds.width.round() + 160, bounds.height.round() + 85),
          fill: toChartColor(Theme.of(context).primaryColor.withAlpha(180)))
    ],
        radius: 12,
        roundBottomLeft: true,
        roundBottomRight: true,
        roundTopLeft: true,
        roundTopRight: true,
        stackedBarPadding: 10));
    final textStyle = style.TextStyle();
    textStyle.color = charts.MaterialPalette.teal.shadeDefault;
    textStyle.fontSize = 14;
    canvas.drawText(
        TextElement("Value: ${point!.valueRounded}${metric.unit}",
            style: textStyle),
        (bounds.left - 70).round(),
        (bounds.top + 40).round());
    canvas.drawText(
        TextElement(
            "Time: ${DateFormat("dd-MM h:m:s").format(point!.timestamp)}",
            style: textStyle),
        (bounds.left - 70).round(),
        (bounds.top + 60).round());
    canvas.drawText(
        TextElement(
            "Location: ${point!.location.isNotEmpty ? point!.location : "Unknown"}",
            style: textStyle),
        (bounds.left - 70).round(),
        (bounds.top + 80).round());
    if (devicesMap.isNotEmpty) {
      canvas.drawText(
          TextElement("Device: ${devicesMap[point!.deviceID]!.name}",
              style: textStyle),
          (bounds.left - 70).round(),
          (bounds.top + 100).round());
    }
  }
}