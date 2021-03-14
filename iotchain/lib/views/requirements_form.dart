import 'package:flutter/material.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:iotchain/controllers/blockchain_adapter.dart';
import 'package:iotchain/controllers/references_adapter.dart';
import 'package:iotchain/model/metric_model.dart';
import 'package:iotchain/model/requirements_model.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class RequirementsForm extends StatefulWidget {
  String assetID;
  RequirementsForm({String assetID}) {
    this.assetID = assetID;
  }

  @override
  _RequirementsFormState createState() => _RequirementsFormState();
}

class _RequirementsFormState extends State<RequirementsForm> {
  Requirements requirements = Requirements();

  final _formKey = GlobalKey<FormState>();

  Future<void> submitAsset() async {
    if (_formKey.currentState.validate()) {
      try {
        requirements.assetID = widget.assetID;
        var jsonData = JsonMapper.serialize(requirements);
        if (await Blockchain.submitTransaction(
                "requirements", "Assign", jsonData) !=
            null) {
          Navigator.pop(context);
        }
      } on Exception catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assign requirements"),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                              MultiSelectBottomSheetField(
                                initialValue:
                                    requirements.metrics.keys.toList(),
                                title: Text("Metrics"),
                                buttonText: Text("Select metrics"),
                                listType: MultiSelectListType.CHIP,
                                chipColor: Colors.teal.shade800,
                                selectedColor: Colors.teal,
                                selectedItemsTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                buttonIcon: Icon(Icons.add),
                                items: References.metrics
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
                                              metric,
                                              References.defaultRequirements[
                                                  metric]))));
                                },
                              ),
                            ],
                          ),
                        ),
                        ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 6),
                          children: requirements.metrics.entries.map(
                                  (kvp) => SafeArea(
                                  top: false,
                                  bottom: false,
                                  child: Hero(
                                      tag: kvp.key, child: _requirementControl(
                                      References.metricsMap[kvp.key],
                                      kvp.value)))).toList(),

                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: submitAsset,
                              child: const Text("SUBMIT REQUIREMENTS",
                                  style: TextStyle(fontSize: 20)),
                            )),
                      ].expand((widget) => [
                            widget,
                            SizedBox(
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
        child: Container(
          height: 100,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    children: <Widget>[
                      Text(metric.name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Spacer(),
                      Container(
                          width: 125.0,
                          child: TextFormField(
                            initialValue: req.minLimit.toString(),
                            decoration: InputDecoration(
                                filled: true,
                                labelText: "Min",
                                suffixText: metric.unit),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() => req.minLimit = num.parse(value));
                            },
                          )
                      ),
                      SizedBox(width: 10,),
                      Container(
                          width: 100.0,
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
                          )
                      )
                    ],
                  )),
            ),
          ),
        ),
      );
}
