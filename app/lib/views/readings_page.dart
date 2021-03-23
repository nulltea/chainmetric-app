import 'package:chainmetric/controllers/readings_controller.dart';
import 'package:chainmetric/model/readings_model.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class ReadingsPage extends StatefulWidget {
  final String assetID;

  ReadingsPage({this.assetID});

  @override
  _ReadingsPageState createState() => _ReadingsPageState();
}

class _ReadingsPageState extends State<ReadingsPage> {
  MetricReadings readings = MetricReadings();

  final _refreshKey = GlobalKey<RefreshIndicatorState>();

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

  Widget _listBuilder(BuildContext context, int index) => InkWell(
    child: SafeArea(
        top: false,
        bottom: false,
        child: Hero(
          tag: index,
          child: _streamChart(readings.streams.entries.elementAt(index).value),
        ),
      ),
  );

  Widget _streamChart(List<MetricReadingPoint> stream) => Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 160,
        child: TimeSeriesChart(_fromReadingsStream(stream),
          animate: true,

        )
      ),
    ),
  );


  Future _refreshData() {
    _refreshKey.currentState?.show();
    return ReadingsController.getReadings(widget.assetID).then((value) =>
        setState(() => readings = value)
    );
  }

  List<Series<MetricReadingPoint, DateTime>> _fromReadingsStream(List<MetricReadingPoint> stream) {
    return [
      Series<MetricReadingPoint, DateTime>(
        id: "Readings",
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (sales, _) => sales.timestamp,
        measureFn: (sales, _) => sales.value,
        data: stream,
      )
    ];
  }
}
