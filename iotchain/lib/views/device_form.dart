import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:iotchain/controllers/blockchain_adapter.dart';
import 'package:iotchain/controllers/references_adapter.dart';
import 'package:iotchain/model/device_model.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DeviceForm extends StatefulWidget {
  @override
  _DeviceFormState createState() => _DeviceFormState();
}

class _DeviceFormState extends State<DeviceForm> {
  Device device;
  QRViewController controller;
  String scannerMsg = "Scan a code";

  final GlobalKey _qrKey = GlobalKey(debugLabel: "QR");
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return device == null
      ? _buildScanner(context)
      : _buildForm(context);
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget _buildForm(BuildContext context) {
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
                          initialValue: device.name,
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
                          initialValue: device.hostname,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter the device hostname",
                            labelText: "Hostname",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please provide device hostname";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => device.hostname = value);
                          },
                        ),
                        DropdownButtonFormField(
                          value: device.profile,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Choose the device profile",
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
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            boxShadow: kElevationToShadow[1],
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: Column(children: [
                            MultiSelectBottomSheetField(
                              initialValue: device.supports,
                              title: Text("Supports metrics"),
                              buttonText: Text("Select supported metrics"),
                              listType: MultiSelectListType.CHIP,
                              chipColor: Colors.teal.shade800,
                              selectedColor: Colors.teal,
                              selectedItemsTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              buttonIcon: Icon(Icons.arrow_drop_down),
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
                            )
                          ],),
                        ),
                        DropdownButtonFormField(
                          value: device.holder,
                          decoration: InputDecoration(
                            hintText: "Choose the holder organization",
                            labelText: "Holder",
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
                        TextFormField(
                          initialValue: device.location,
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
                            setState(() => device.location = value);
                          },
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: _submitAsset,
                              child: const Text("Register device",
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

  Widget _buildScanner(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(scannerMsg),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    Timer timer;

    controller.scannedDataStream.listen((scanData) {
      if (scanData != null) {
        Device dev;
        try {
          dev = _parseQRCode(scanData.code);
          dev.name = dev.hostname;
          dev.profile = "common";
          dev.state = "active";
          dev.location = "warehouse"; // TODO: location determination via GPS
          dev.holder = "supplierMSP"; // TODO: holder determination via user identity
        } on Exception catch (e)  {
          setState(() => scannerMsg = "QR is invalid: ${e.toString()}");
          if (timer != null) timer.cancel();
          timer = Timer(Duration(seconds: 5), () {
            setState(() => scannerMsg = "Scan a code");
          });
          return;
        }
        controller?.dispose();
        setState(() => device = dev);
      } else {
        setState(() => scannerMsg = "Scan a code");
      }

    });
  }

  Device _parseQRCode(String code) {
    var exp = RegExp(r"\$\{(.+?)\}");
    var match = exp.firstMatch(code);
    if (match == null) throw Exception("expected pattern does not match");

    var data = match.group(1);
    var parts = data.split(';');
    if (parts.length != 3) throw Exception("coded data is not valid");

    Device dev = Device();

    dev.hostname = parts[0];
    dev.ip = parts[1];

    var metrics = parts[2].split(',');
    if (metrics.isEmpty || metrics.length == 1 && metrics[0].isEmpty) {
      throw Exception("device must support at least one metric");
    }

    dev.supports = metrics;

    return dev;
  }

  Future<void> _submitAsset() async {
    if (_formKey.currentState.validate()) {
      try {
        var jsonData = JsonMapper.serialize(device);
        if (await Blockchain.submitTransaction("devices", "Register", jsonData) != null) {
          Navigator.pop(context);
        }
      } on Exception catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }
}
