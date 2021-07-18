import 'dart:async';

import 'package:chainmetric/controllers/preferences_adapter.dart';
import 'package:chainmetric/models/device_model.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import 'gps_adapter.dart';

typedef void DeviceDisconnectFunc();

class Bluetooth {
  static final driver = FlutterReactiveBle();
  static final connectionTimeout = Duration(seconds: 15);

  static Map<String, PairedDevice> pairedDevices = {};
  static Map<String, DeviceDisconnectFunc> connectedDevices = {};

  static Future<void> init() {
    pairedDevices = Preferences.getPairedDevices();
    return driver.initialize();
  }

  static Function discoverDevice(String deviceID, {@required Function(DiscoveredDevice) onFound}) {
    StreamSubscription sub;

    sub = driver.scanForDevices(
        withServices: [  ]
    ).listen((device) {
      if (device.name.contains("chainmetric")) {
        sub.cancel();
        if (!pairedDevices.containsKey(deviceID)) {
          pairedDevices[deviceID] = PairedDevice()
            ..deviceID = deviceID
            ..hardwareID=device.id
            ..advertisedName=device.name
            ..rssi=device.rssi;

          Preferences.setPairedDevices(pairedDevices);
        }
        onFound(device);
      }
    });

    return sub.cancel;
  }

  static Function connectToDevice(String deviceID, {@required Function(String) onConnect}) {
    StreamSubscription sub;
    bool triggered = false;

    assert(isPaired(deviceID), "device was never paired yet");
    assert(!isConnected(deviceID), "device is already connected");

    sub = driver.connectToDevice(
        id: pairedDevices[deviceID].hardwareID,
        connectionTimeout: connectionTimeout,
        servicesWithCharacteristicsToDiscover: {
          GeoService.serviceUUID: GeoService.characteristicUUIDs
        }
    ).listen((event) {
      print(event);
      if (event.connectionState == DeviceConnectionState.connected && !triggered) {
        triggered = true;
        connectedDevices[deviceID] = sub.cancel;

        onConnect(deviceID);
      }
    });

    return sub.cancel;
  }

  static Future<void> forgetDevice(String deviceID) async {
    if (isConnected(deviceID)) connectedDevices[deviceID]();
    pairedDevices.remove(deviceID);
    Preferences.setPairedDevices(pairedDevices);
  }

  static String getHardwareID(String deviceID) {
    assert(isPaired(deviceID), "device was never paired yet");
    return pairedDevices[deviceID].hardwareID;
  }

  static bool isPaired(String deviceID) => pairedDevices.containsKey(deviceID);

  static bool isConnected(String deviceID) => connectedDevices.containsKey(deviceID);
}
