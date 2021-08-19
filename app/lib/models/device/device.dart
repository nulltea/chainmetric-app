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

  Device();

  @JsonKey(ignore: true)
  String get stateView => state?.toSentenceCase() ?? "Unknown";
  @JsonKey(ignore: true)
  Icon get stateIcon {
    switch (state) {
      case "online":
        return Icon(Icons.circle, color: Colors.green.withAlpha(200));
      case "offline":
        return Icon(Icons.circle, color: Colors.red.withAlpha(200));
      default:
        return Icon(Icons.help, color: Colors.grey.withAlpha(200));
    }
  }

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}

@JsonSerializable()
class DeviceProfile {
  late String name;
  String? profile;
  @JsonKey(name: "color_hex")
  late String colorHex;
  Color get color => colorFromHex(colorHex);

  DeviceProfile();

  Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse("FF$hexCode", radix: 16));
  }

  factory DeviceProfile.fromJson(Map<String, dynamic> json) => _$DeviceProfileFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceProfileToJson(this);
}

@JsonSerializable()
class DeviceCommandRequest {
  @JsonKey(name: "device_id")
  late String deviceID;
  late DeviceCommand command;
  List<Object>? args;

  DeviceCommandRequest(this.deviceID, this.command, {this.args});

  factory DeviceCommandRequest.fromJson(Map<String, dynamic> json) => _$DeviceCommandRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceCommandRequestToJson(this);
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

  DeviceCommandLogEntry();

  factory DeviceCommandLogEntry.fromJson(Map<String, dynamic> json) => _$DeviceCommandLogEntryFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceCommandLogEntryToJson(this);
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

  PairedDevice();

  factory PairedDevice.fromJson(Map<String, dynamic> json) => _$PairedDeviceFromJson(json);
  Map<String, dynamic> toJson() => _$PairedDeviceToJson(this);
}
