import 'package:flutter/material.dart';
import 'package:iotchain/controllers/assets_controller.dart';
import 'package:iotchain/controllers/references_adapter.dart';
import 'package:iotchain/model/asset_model.dart';
import 'package:iotchain/shared/utils.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:overlay_screen/overlay_screen.dart';

class AssetForm extends StatefulWidget {
  final Asset model;

  AssetForm({this.model});

  @override
  _AssetFormState createState() => _AssetFormState(model);
}

class _AssetFormState extends State<AssetForm> {
  final _formKey = GlobalKey<FormState>();
  Asset asset = Asset();

  _AssetFormState(Asset model) {
    this.asset = model ?? Asset();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input asset"),
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
                        TextFormField(
                          initialValue: asset.name,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter an asset name",
                            labelText: "Name",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please provide name for new asset";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => asset.name = value);
                          },
                        ),
                        TextFormField(
                          initialValue: asset.sku,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter an SKU code",
                            labelText: "SKU code",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please provide SKU code for new asset";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => asset.sku = value);
                          },
                        ),
                        DropdownButtonFormField(
                          value: asset.type,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Choose asset type",
                            labelText: "Asset type",
                          ),
                          items: References.assetTypes
                              .map<DropdownMenuItem<String>>(
                                  (type) => DropdownMenuItem<String>(
                                        value: type.type,
                                        child: Text(type.name),
                                      ))
                              .toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please choose an asset type";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => asset.type = value);
                          },
                        ),
                        TextFormField(
                          initialValue: asset.cost.toString(),
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter an cost",
                            labelText: "Cost",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please provide cost for new asset";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() => asset.cost = num.parse(value));
                          },
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              boxShadow: kElevationToShadow[1],
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Stack(children: [
                              Text("Amount",
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontSize: 16)),
                              Row(children: [
                                NumberPicker.horizontal(
                                  initialValue: asset.amount ?? 1,
                                  minValue: 1,
                                  maxValue: 100,
                                  haptics: true,
                                  highlightSelectedValue: true,
                                  onChanged: (value) =>
                                      setState(() => asset.amount = value),
                                )
                              ], mainAxisAlignment: MainAxisAlignment.center)
                            ])),
                        TextFormField(
                          initialValue: asset.info,
                          decoration: InputDecoration(
                            hintText: "Enter asset description",
                            labelText: "Description",
                            filled: true,
                          ),
                          onChanged: (value) {
                            setState(() => asset.info = value);
                          },
                          maxLines: 5,
                        ),
                        DropdownButtonFormField(
                          value: asset.holder,
                          decoration: InputDecoration(
                            hintText: "Choose the owner organization",
                            labelText: "Owned by",
                            filled: true,
                          ),
                          items: References.organizations
                              .map<DropdownMenuItem<String>>(
                                  (org) => DropdownMenuItem<String>(
                                        value: org.mspID,
                                        child: Text(org.name),
                                      ))
                              .toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please choose an owner organization";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => asset.holder = value);
                          },
                        ),
                        TextFormField(
                          initialValue: asset.location,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter the device location",
                            labelText: "Location",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please specify the device location";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => asset.location = value);
                          },
                        ),
                        Container(
                          child: Column(
                            children: [
                              TextFormField(
                                  initialValue: asset.tags.join(' '),
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: "Separate tags with Space",
                                    labelText: "Tags",
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please specify the device location";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.trim().isEmpty) {
                                        asset.tags = [];
                                        return;
                                      }
                                      asset.tags = value.trim().split(' ');
                                    });
                                  }),
                              MultiSelectChipDisplay(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                ),
                                chipColor: Colors.teal,
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                items: asset.tags
                                    .map((tag) => MultiSelectItem(
                                          tag,
                                          "#$tag",
                                        ))
                                    .toList(),
                                onTap: (value) {
                                  setState(() => asset.tags.remove(value));
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: decorateWithLoading(context, _submitAsset),
                              child: const Text("SUBMIT ASSET",
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

  Future<void> _submitAsset() async {
    if (_formKey.currentState.validate()) {
      try {
        if (await AssetsController.upsertAsset(asset)) {
          Navigator.pop(context);
        }
      } on Exception catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }
}
