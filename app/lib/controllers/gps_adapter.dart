import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:chainmetric/controllers/bluetooth_adapter.dart';
import 'package:chainmetric/controllers/preferences_adapter.dart';
import 'package:chainmetric/main.dart';
import 'package:chainmetric/models/device_model.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:global_configuration/global_configuration.dart';

import 'devices_controller.dart';

class GeoService {
  static final serviceUUID = Uuid.parse(
      GlobalConfiguration().getValue("device_bluetooth_service_uuid")
  );

  static final eastCoordinateUUID = Uuid.parse(
      "00002ab1-0000-1000-8000-00805f9b34fb"
  );

  static final northCoordinateUUID = Uuid.parse(
      "00002ab0-0000-1000-8000-00805f9b34fb"
  );

  static final locationNameUUID = Uuid.parse(
      "00002ab5-0000-1000-8000-00805f9b34fb"
  );

  static final characteristicUUIDs = [
    eastCoordinateUUID,
    northCoordinateUUID,
    locationNameUUID
  ];

  static Future<void> postLocation(String deviceID) async {
    var hardwareID = Bluetooth.getHardwareID(deviceID);

    if (!Bluetooth.isConnected(deviceID)) {
      if (await DevicesController.sendCommand(deviceID, DeviceCommand.pairBluetooth)) {
        Bluetooth.connectToDevice(deviceID, onConnect: postLocation);
      }
      return;
    }

    var eastCoordinateChar = QualifiedCharacteristic(
        serviceId: serviceUUID,
        characteristicId: eastCoordinateUUID,
        deviceId: hardwareID
    );
    var northCoordinateChar = QualifiedCharacteristic(
        serviceId: serviceUUID,
        characteristicId: northCoordinateUUID,
        deviceId: hardwareID
    );
    var locationNameChar = QualifiedCharacteristic(
        serviceId: serviceUUID,
        characteristicId: locationNameUUID,
        deviceId: hardwareID
    );

    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );

    var latitudePayload = Uint8List(8)..buffer.asByteData().setFloat64(0, position.latitude);
    var longitudePayload = Uint8List(8)..buffer.asByteData().setFloat64(0, position.longitude);

    await Bluetooth.driver.writeCharacteristicWithoutResponse(
        eastCoordinateChar, value: latitudePayload.toList()
    );

    await Bluetooth.driver.writeCharacteristicWithoutResponse(
        northCoordinateChar, value: longitudePayload.toList()
    );

    var locationName = "Unknown";
    var placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      locationName = "${placemarks.first.street} ${placemarks.first.name}";
    }
    var locationNamePayload = utf8.encode(locationName);

    await Bluetooth.driver.writeCharacteristicWithoutResponse(
        locationNameChar, value: locationNamePayload
    );
  }

  static void startActivelyShareLocation() {
    FlutterIsolate.spawn(tryShareLocation, null);
  }

  static void tryShareLocation(Map<String, PairedDevice> devices) async {
    initJson();
    await Preferences.init();
    await Bluetooth.init();
    await initConfig();

    Timer.periodic(Duration(minutes: 1), (t) {
      Bluetooth.pairedDevices.forEach((deviceID, info) {
        if (!Bluetooth.isConnected(deviceID)) {
          Bluetooth.connectToDevice(deviceID, onConnect: postLocation);
          return;
        }
        postLocation(info.hardwareID);
      });
    });
  }
}
