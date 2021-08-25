import 'package:chainmetric/platform/repositories/localdata_json.dart';
import 'package:chainmetric/infrastructure/repositories/requirements_fabric.dart';
import 'package:chainmetric/models/readings/metric.dart';
import 'package:chainmetric/models/assets/requirements.dart';
import 'package:chainmetric/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class RequirementsForm extends StatefulWidget {
  final Requirements? model;

  const RequirementsForm({this.model});

  @override
  _RequirementsFormState createState() => _RequirementsFormState();
}

class _RequirementsFormState extends State<RequirementsForm> {
  late Requirements requirements;
  final ScrollController _controller = ScrollController();
  final _formKey = GlobalKey<FormState>();

  _RequirementsFormState() {
    requirements = widget.model ?? Requirements();
  }

  String get periodStr =>
      "${requirements.periodDuration.inHours}h ${requirements.periodDuration.inMinutes - requirements.periodDuration.inHours * 60}m ${requirements.periodDuration.inSeconds - requirements.periodDuration.inMinutes * 60}s";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign requirements"),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...[
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            boxShadow: kElevationToShadow[1],
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      const Text("Period"),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () =>
                                            showPeriodPicker(context),
                                        child: Text(periodStr),
                                      )
                                    ],
                                  )),
                              MultiSelectBottomSheetField(
                                  initialValue:
                                      requirements.metrics.keys.toList(),
                                  title: const Text("Metrics"),
                                  buttonText: const Text("Select metrics"),
                                  listType: MultiSelectListType.CHIP,
                                  colorator: (dynamic v) =>
                                      Colors.teal.shade800,
                                  selectedColor: Colors.teal,
                                  selectedItemsTextStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  buttonIcon: const Icon(Icons.add),
                                  items: LocalData.metrics!
                                      .where((metric) => !requirements.metrics
                                          .containsKey(metric.name))
                                      .map((metric) => MultiSelectItem(
                                            metric.metric,
                                            metric.name!,
                                          ))
                                      .toList(),
                                  onSelectionChanged: (value) {
                                    setState(() => requirements.metrics
                                        .addEntries(value.map((metric) =>
                                            MapEntry(
                                                metric as String,
                                                LocalData.defaultRequirements![
                                                    metric]))));
                                  },
                                  onConfirm: (selected) => setState(() {
                                        final toRemoveKeys = <String?>[];
                                        for (final metric
                                            in requirements.metrics.keys) {
                                          if (!selected.contains(metric)) {
                                            toRemoveKeys.add(metric);
                                          }
                                        }

                                        for (final key in toRemoveKeys) {
                                          requirements.metrics.remove(key);
                                        }
                                      })),
                            ],
                          ),
                        ),
                        ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _controller,
                          children: requirements.metrics.entries
                              .map((kvp) => SafeArea(
                                  top: false,
                                  bottom: false,
                                  child: Hero(
                                      tag: kvp.key,
                                      child: _requirementControl(
                                          LocalData.metricsMap[kvp.key]!,
                                          kvp.value!))))
                              .toList(),
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: decorateWithLoading(context, _submit),
                              child: const Text("SUBMIT REQUIREMENTS",
                                  style: TextStyle(fontSize: 20)),
                            )),
                      ].expand((widget) => [
                            widget,
                            const SizedBox(
                              height: 24,
                            )
                          ])
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _requirementControl(Metric metric, Requirement req) => Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, right: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Stack(fit: StackFit.expand, children: [
                  Text(metric.name!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: TextFormField(
                        initialValue: req.minLimit.toString(),
                        decoration: InputDecoration(
                            filled: true,
                            labelText: "Min",
                            suffixText: metric.unit!.trim()),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() => req.minLimit = num.parse(value));
                        },
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: TextFormField(
                        initialValue: req.maxLimit.toString(),
                        decoration: InputDecoration(
                            filled: true,
                            labelText: "Max",
                            suffixText: metric.unit),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() => req.maxLimit = num.parse(value));
                        },
                      ))
                    ],
                  )
                ])),
          ),
        ),
      );

  void showPeriodPicker(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => CupertinoTimerPicker(
        initialTimerDuration: requirements.periodDuration,
        onTimerDurationChanged: (value) =>
            setState(() => requirements.period = value.inSeconds),
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (await RequirementsController.assignRequirements(requirements)) {
          Navigator.pop(context);
        }
      } on Exception catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }
}
