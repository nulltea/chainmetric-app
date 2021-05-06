import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

class Bluetooth {
  static final FlutterBlue _bluetooth = FlutterBlue.instance;

  static Future<void> init() async {
    _bluetooth.state.listen((state) {
      if (state == BluetoothState.off) {

      } else if (state == BluetoothState.on) {

      }
    });
  }

  static Future<BluetoothDevice> pairWithDevice(String deviceID) async {
    BluetoothDevice device;
    StreamSubscription<ScanResult> scanSub;

    scanSub = _bluetooth.scan(
        withServices: [Guid("F8AE4978-5AAB-46C3-A8CB-127F347EAA01")]
    ).listen((result) {
      if (result.device.name.contains("chainmetric")) {
        device = result.device;
        _bluetooth.stopScan();
        scanSub.cancel();
      }
    });

    return device;
  }
}
