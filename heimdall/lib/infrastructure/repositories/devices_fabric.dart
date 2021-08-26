import 'dart:async';
import 'dart:convert';

import 'package:chainmetric/models/device/device.dart';
import 'package:talos/talos.dart';

class DevicesController {
  static Future<List<Device>?> getDevices() async {
    final String data = await (Hyperledger.evaluateTransaction("devices", "All")
        as FutureOr<String>);

    try {
      return data.isNotEmpty
          ? Device.listFromJson(json.decode(data))
          : <Device>[];
    } on Exception catch (e) {
      print(e.toString());
    }

    return <Device>[];
  }

  static Future<bool> registerDevice(Device device) {
    final jsonData = json.encode(device.toJson());
    return Hyperledger.trySubmitTransaction("devices", "Register", jsonData);
  }

  static Future<bool> sendCommand(String deviceID, DeviceCommand cmd,
      {List<Object>? args}) {
    final jsonData =
        json.encode(DeviceCommandRequest(deviceID, cmd, args: args).toJson());
    return Hyperledger.trySubmitTransaction("devices", "Command", jsonData);
  }

  static Future<List<DeviceCommandLogEntry>?> commandsLog(
      String deviceID) async {
    final String data = await (Hyperledger.evaluateTransaction(
        "devices", "CommandsLog", deviceID) as FutureOr<String>);

    try {
      return data.isNotEmpty
          ? DeviceCommandLogEntry.listFromJson(json.decode(data))
          : <DeviceCommandLogEntry>[];
    } on Exception catch (e) {
      print(e.toString());
    }

    return <DeviceCommandLogEntry>[];
  }

  static Future<bool> unbindDevice(String? id) {
    return Hyperledger.trySubmitTransaction("devices", "Unbind", id);
  }
}
