import 'dart:ui';

import 'package:chainmetric/models/location_model.dart';
import 'package:flutter/material.dart';
import 'package:chainmetric/shared/extensions.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class Device {
  String id;
  String ip;
  String mac;
  String name;
  String hostname;
  String profile;
  List<String> supports = <String>[];
  String holder;
  String state;
  Location location;


  @JsonProperty(ignore: true)
  String get stateView => state?.toSentenceCase() ?? "Unknown";
  @JsonProperty(ignore: true)
  Icon get stateIcon {
    switch (state) {
      case "online":
        return Icon(Icons.circle, color: Colors.green.withAlpha(200));
        break;
      case "offline":
        return Icon(Icons.circle, color: Colors.red.withAlpha(200));
        break;
      default:
        return Icon(Icons.help, color: Colors.grey.withAlpha(200));
        break;
    }
  }
}

@jsonSerializable
class DeviceProfile {
  String name;
  String profile;
  @JsonProperty(name: "color_hex")
  String colorHex;
  Color get color => colorFromHex(colorHex);

  Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse("FF$hexCode", radix: 16));
  }
}

@jsonSerializable
class DeviceCommandRequest {
  @JsonProperty(name: "device_id")
  String deviceID;
  DeviceCommand command;
  List<Object> args;

  DeviceCommandRequest(this.deviceID, this.command, {this.args});
}

@jsonSerializable
class DeviceCommandLogEntry {
  @JsonProperty(name: "device_id")
  String deviceID;
  DeviceCommand command;
  List<Object> args;
  DeviceCommandStatus status;
  String error;
  DateTime timestamp;
}

@jsonSerializable
enum DeviceCommand {
  pause,
  resume,
  pairBluetooth
}

@jsonSerializable
enum DeviceCommandStatus {
  completed,
  processing,
  failed
}

@jsonSerializable
class PairedDevice {
  String hardwareID;
  String deviceID;
  String advertisedName;
  @JsonProperty(ignore: true) int rssi;
}
