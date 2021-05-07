import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Bluetooth {
  static final FlutterBlue _bluetooth = FlutterBlue.instance;

  static Function init({Function onDisabled, Function onReady}) {
    StreamSubscription stateSub;

    stateSub = _bluetooth.state.listen((state) {
      if (state == BluetoothState.off) {
        onDisabled();
      } else if (state == BluetoothState.on) {
        onReady();
        stateSub.cancel();
      }
    });

    return stateSub.cancel;
  }


  static Function scanDevices(String deviceID, {@required Function(BluetoothDevice) onPair}) {
    StreamSubscription scanSub;

    scanSub = _bluetooth.scan(
        //withServices: [Guid("F8AE4978-5AAB-46C3-A8CB-127F347EAA01")]
    ).listen((result) {
      if (result.device.name.contains("chainmetric")) {
        onPair(result.device);
        _bluetooth.stopScan();
        scanSub.cancel();
      }
    });

    return () {
      _bluetooth.stopScan();
      scanSub.cancel();
    };
  }
}
