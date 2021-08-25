import 'dart:convert';

import 'package:chainmetric/models/device/device.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Map<String, PairedDevice> get pairedDevices {
    final source = prefs.getString("paired_devices");
    if (source == null) {
      return <String, PairedDevice>{};
    }

    return Map<String, Map<String, dynamic>>.from(json.decode(source))
        .map((key, value) => MapEntry(key, PairedDevice.fromJson(value)));
  }

  static set pairedDevices(Map<String, PairedDevice> value) {
   prefs.setString("paired_devices",
        json.encode(value.map((key, value) => MapEntry(key, value.toJson()))));
  }

  static String? get accessToken {
    return prefs.getString("access_token");
  }

  static set accessToken(String? value) {
    if (value != null) {
      prefs.setString("access_token", value);
    }
  }
}
