import 'dart:convert';

import 'package:chainmetric/models/device/device.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences prefs;

  static Map<String, PairedDevice> getPairedDevices() {
    final source = prefs.getString("paired_devices");
    if (source == null) {
      return <String, PairedDevice>{};
    }

    return Map<String, Map<String, dynamic>>.from(json.decode(source))
        .map((key, value) => MapEntry(key, PairedDevice.fromJson(value)));
  }

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setPairedDevices(Map<String, PairedDevice> value) {
    return prefs.setString("paired_devices",
        json.encode(value.map((key, value) => MapEntry(key, value.toJson()))));
  }
}
