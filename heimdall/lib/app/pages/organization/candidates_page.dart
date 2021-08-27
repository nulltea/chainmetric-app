import 'package:chainmetric/app/utils/utils.dart' as utils;
import 'package:chainmetric/infrastructure/repositories/certificates_vault.dart';
import 'package:chainmetric/infrastructure/services/identity_grpc.dart';
import 'package:chainmetric/models/identity/user.pb.dart';
import 'package:flutter/material.dart';

class CandidatesPage extends StatefulWidget {
  const CandidatesPage({Key? key}) : super(key: key);

  @override
  _CandidatesPageState createState() => _CandidatesPageState();
}

class _CandidatesPageState extends State<CandidatesPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final PageController _controller;
  
  late List<User> candidates;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Candidates"),
      ),
      body: _candidatePageView(context)
    );
  }

  Widget _candidatePageView(BuildContext context) => PageView.builder(
    controller: _controller = PageController(viewportFraction: 0.93),
    itemCount: readings.streams?.length ?? 0,
    itemBuilder: _pagerBuilder,
    onPageChanged: _onPageChanged,
    physics: scrollLocked
        ? const NeverScrollableScrollPhysics()
        : const AlwaysScrollableScrollPhysics(),
  );

  Widget _pagerBuilder(BuildContext context, int index) {
    final record = readings.streams!.entries.elementAt(index);
    return SafeArea(
      child: _chartPage(record.key!, record.value!),
    );
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
                            Text(metric.unit!,
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
                            : "Last updated \n${stream.last!.timestamp.timeAgoSinceDate()}",
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

  @override
  void initState() {
    super.initState();
  }

  Future<void> submitRegistration() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      await IdentityService(organization!,
          certificate: await CerificatesResolver(organization!)
              .resolveBytes("identity-client"))
          .enroll(request);
    } on Exception catch (e) {
      utils.displayError(context, e);
    }
  }
}
