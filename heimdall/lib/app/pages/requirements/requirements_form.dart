import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/platform/repositories/localdata_json.dart';
import 'package:chainmetric/infrastructure/repositories/requirements_fabric.dart';
import 'package:chainmetric/models/readings/metric.dart';
import 'package:chainmetric/models/assets/requirements.dart';
import 'package:chainmetric/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
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
  final _formKey = GlobalKey<FormState>();

  _RequirementsFormState();

  String get periodStr =>
      "${requirements.periodDuration.inHours}h ${requirements.periodDuration.inMinutes - requirements.periodDuration.inHours * 60}m ${requirements.periodDuration.inSeconds - requirements.periodDuration.inMinutes * 60}s";

  @override
  void initState() {
    super.initState();
    requirements = widget.model ?? Requirements.forAsset("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assign requirements", style: AppTheme.title2
            .override(fontFamily: "IBM Plex Mono", fontSize: 24)),
      centerTitle: false,
      elevation: 4,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                      MultiSelectBottomSheetField<String?>(
                          initialValue:
                              requirements.metrics.keys.toList(),
                          title: Text("Metrics", style: AppTheme.subtitle1),
                          buttonText: const Text("Select metrics"),
                          listType: MultiSelectListType.CHIP,
                          colorator: (dynamic v) =>
                              Theme.of(context).primaryColor,
                          selectedColor: Theme.of(context).primaryColor,
                          selectedItemsTextStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          backgroundColor: AppTheme.appBarBG,
                          chipDisplay: MultiSelectChipDisplay(
                            colorator: (dynamic v) =>
                                Theme.of(context).primaryColor,
                            textStyle: TextStyle(
                                fontFamily: "Roboto",
                                color: Theme.of(context).backgroundColor,
                                fontWeight: FontWeight.bold),
                          ),
                          buttonIcon: const Icon(Icons.add),
                          items: LocalDataRepo.metrics!
                              .where((metric) => !requirements.metrics
                                  .containsKey(metric.name))
                              .map((metric) => MultiSelectItem(
                                    metric.metric,
                                    metric.name,
                                  ))
                              .toList(),
                          onSelectionChanged: (value) {
                            setState(() => requirements.metrics
                                .addEntries(value.map((metric) =>
                                    MapEntry(
                                        metric!,
                                        LocalDataRepo
                                                .defaultRequirements![
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
                const SizedBox(height: 24),
                for (var kvp in requirements.metrics.entries)
                  SafeArea(
                      top: false,
                      bottom: false,
                      child: Hero(
                          tag: kvp.key,
                          child: _requirementControl(
                              LocalDataRepo.metricsMap[kvp.key]!,
                              kvp.value!))),
                const SizedBox(height: 24),
                SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: decorateWithLoading(context, _submit),
                      child: const Text("SUBMIT REQUIREMENTS",
                          style: TextStyle(fontSize: 20)),
                    ))
              ]),
        ),
      ),
    );
  }

  Widget _requirementControl(Metric metric, Requirement req) => Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
          child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(metric.name,
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
                              suffixText: metric.unit.trim()),
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
      );

  void showPeriodPicker(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      elevation: 5,
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
        } else {
          throw Exception("Something went wrong during assigning requirements.\n"
              "Please try again soon");
        }
      } on Exception catch (e) {
        displayError(context, e);
      }
    }
  }
}
