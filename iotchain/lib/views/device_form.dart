import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:iotchain/controllers/blockchain_adapter.dart';
import 'package:iotchain/controllers/references_adapter.dart';
import 'package:iotchain/model/device_model.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class DeviceForm extends StatefulWidget {
  @override
  _DeviceFormState createState() => _DeviceFormState();
}

class _DeviceFormState extends State<DeviceForm> {
  Device device = Device();

  final _formKey = GlobalKey<FormState>();

  Future<void> submitAsset() async {
    if (_formKey.currentState.validate()) {
      try {
        var jsonData = JsonMapper.serialize(device);
        await Blockchain.submitTransaction("device", "Insert", jsonData);
        Navigator.pop(context);
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
        title: Text("Register device"),
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
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter an device name",
                            labelText: "Name",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please provide name for the device";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => device.name = value);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter a device URL",
                            labelText: "URL",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please provide URL for the device";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => device.url = value);
                          },
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Choose device profile",
                            labelText: "Profile",
                          ),
                          items: References.deviceProfiles
                              .map<DropdownMenuItem<String>>(
                                  (profile) => DropdownMenuItem<String>(
                                        value: profile.profile,
                                        child: Text(profile.name),
                                      ))
                              .toList(),
                          onChanged: (value) {
                            setState(() => device.profile = value);
                          },
                        ),
                        MultiSelectBottomSheetField(
                          title: Text("Supports metrics"),
                          buttonText: Text("Selected supported metrics"),
                          listType: MultiSelectListType.CHIP,
                          chipColor: Colors.teal.shade800,
                          selectedColor: Colors.teal,
                          selectedItemsTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          items: References.metrics
                              .map((metric) => MultiSelectItem(
                                    metric.metric,
                                    metric.name,
                                  ))
                              .toList(),
                          onSelectionChanged: (value) {
                            setState(() => device.supports = value);
                          },
                        ),
                        MultiSelectChipDisplay(
                          chipColor: Colors.teal,
                          textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          items: device.supports
                              .map((metric) => MultiSelectItem(
                                    metric,
                                    References.metricsMap[metric]?.name ?? "",
                                  ))
                              .toList(),
                          onTap: (value) {
                            setState(() => device.supports.remove(value));
                          },
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: "Choose the holder organization",
                            labelText: "Hold by",
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
                              return "Please choose an holder organization";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => device.holder = value);
                          },
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: submitAsset,
                              child: const Text("Submit asset",
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
}
