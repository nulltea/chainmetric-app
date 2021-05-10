import 'package:chainmetric/model/device_model.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Map<String, PairedDevice> getPairedDevices() {
    try {
      return JsonMapper.deserialize<Map<String, PairedDevice>>(
          prefs.getString("paired_devices")
      ) ?? Map<String, PairedDevice>();
    } on Exception {

    }

    return Map<String, PairedDevice>();
  }

  static Future<bool> setPairedDevices(Map<String, PairedDevice> value) {
    return prefs.setString("paired_devices", JsonMapper.serialize(value));
  }
}
