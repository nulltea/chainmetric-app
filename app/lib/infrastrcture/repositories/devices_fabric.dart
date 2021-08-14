import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:chainmetric/models/device/device.dart';

import '../../controllers/blockchain_adapter.dart';

class DevicesController {
  static Future<List<Device>> getDevices() async {
    final String data = await Blockchain.evaluateTransaction("devices", "All");

    try {
      return data.isNotEmpty
          ? JsonMapper.deserialize<List<Device>>(data)
          : <Device>[];
    } on Exception catch (e) {
      print(e.toString());
    }

    return <Device>[];
  }

  static Future<bool> registerDevice(Device device) {
    final jsonData = JsonMapper.serialize(device);
    return Blockchain.trySubmitTransaction("devices", "Register", jsonData);
  }

  static Future<bool> sendCommand(String deviceID, DeviceCommand cmd, {List<Object> args}) {
    final jsonData = JsonMapper.serialize(DeviceCommandRequest(deviceID, cmd, args: args));
    return Blockchain.trySubmitTransaction("devices", "Command", jsonData);
  }

  static Future<List<DeviceCommandLogEntry>> commandsLog(String deviceID) async {
    final String data = await Blockchain.evaluateTransaction("devices", "CommandsLog", deviceID);

    try {
      return data.isNotEmpty
          ? JsonMapper.deserialize<List<DeviceCommandLogEntry>>(data)
          : <DeviceCommandLogEntry>[];
    } on Exception catch (e) {
      print(e.toString());
    }

    return <DeviceCommandLogEntry>[];
  }

  static Future<bool> unbindDevice(String id) {
    return Blockchain.trySubmitTransaction("devices", "Unbind", id);
  }
}
