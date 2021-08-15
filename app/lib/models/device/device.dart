import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:chainmetric/models/common/location.dart';
import 'package:chainmetric/shared/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part "device.g.dart";

@JsonSerializable()
class Device {
  String? id;
  late String ip;
  String? mac;
  String? name;
  String? hostname;
  String? profile;
  List<String?> supports = <String>[];
  String? holder;
  String? state;
  Location? location;


  @JsonKey(ignore: true)
  String get stateView => state?.toSentenceCase() ?? "Unknown";
  @JsonKey(ignore: true)
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

@JsonSerializable()
class DeviceProfile {
  late String name;
  String? profile;
  @JsonKey(name: "color_hex")
  late String colorHex;
  Color get color => colorFromHex(colorHex);

  Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse("FF$hexCode", radix: 16));
  }
}

@JsonSerializable()
class DeviceCommandRequest {
  @JsonKey(name: "device_id")
  String? deviceID;
  DeviceCommand command;
  List<Object>? args;

  DeviceCommandRequest(this.deviceID, this.command, {this.args});
}

@JsonSerializable()
class DeviceCommandLogEntry {
  @JsonKey(name: "device_id")
  String? deviceID;
  DeviceCommand? command;
  List<Object>? args;
  @JsonKey(unknownEnumValue: DeviceCommandStatus.unknown)
  DeviceCommandStatus? status;
  String? error;
  DateTime? timestamp;
}

enum DeviceCommand {
  pause,
  resume,
  pairBluetooth
}

enum DeviceCommandStatus {
  completed,
  processing,
  failed,
  unknown
}

@JsonSerializable()
class PairedDevice {
  String? hardwareID;
  String? deviceID;
  String? advertisedName;
  @JsonKey(ignore: true) int? rssi;
}
