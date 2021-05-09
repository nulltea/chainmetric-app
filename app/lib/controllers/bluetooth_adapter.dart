import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import 'gps_adapter.dart';

class Bluetooth {
  static final driver = FlutterReactiveBle();
  static final connectionTimeout = Duration(seconds: 15);

  static Map<String, PairedDevice> pairedDevices = {};

  static init({Function onReady}) {
    driver.initialize().then((value) => onReady);
  }

  static Function discoverDevice(String deviceID, {@required Function(DiscoveredDevice) onFound}) {
    StreamSubscription sub;

    sub = driver.scanForDevices(
        withServices: [ GeoService.serviceUUID ]
    ).listen((device) {
      if (device.name.contains("chainmetric")) {
        onFound(device);
        if (!pairedDevices.containsKey(pairedDevices)) {
          pairedDevices[deviceID] = PairedDevice()
            ..deviceID = deviceID
              ..hardwareID=device.id
                ..advertisedName=device.name
                  ..rssi=device.rssi;
        }
        sub.cancel();
      }
    });

    return sub.cancel;
  }

  static Function connectToDevice(String deviceID, {@required Function(String) onConnect}) {
    StreamSubscription sub;

    assert(pairedDevices.containsKey(deviceID), "device was never paired yet");

    sub = driver.connectToDevice(
        id: pairedDevices[deviceID].hardwareID,
        connectionTimeout: connectionTimeout,
        servicesWithCharacteristicsToDiscover: {
          GeoService.serviceUUID: GeoService.characteristicUUIDs
        }
    ).listen((event) {
      if (event.connectionState == DeviceConnectionState.connected) {
        onConnect(event.deviceId);
      }
    });

    return sub.cancel;
  }

  static bool isPaired(String deviceID) => pairedDevices.containsKey(deviceID);
}

class PairedDevice {
  String hardwareID;
  String deviceID;

  String advertisedName;
  int rssi;
}
