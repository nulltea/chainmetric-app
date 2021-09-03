import 'dart:convert';

import 'package:chainmetric/models/identity/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdentitiesRepo {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Map<String, AppUser> get all {
    final source = prefs.getString("app_identities");
    if (source == null) {
      return <String, AppUser>{};
    }

    return Map<String, Map<String, dynamic>>.from(json.decode(source))
        .map((key, value) => MapEntry(key, AppUser.fromJson(value)));
  }

  static void put(AppUser value) {
    final allIdentities = all..
    [value.username] = value;
    _setAppIdentities(allIdentities);
  }

  static void del(String username) {
    final allIdentities = all..remove(username);
    _setAppIdentities(allIdentities);
  }

  static void setCurrent(String username) {
    prefs.setString("current_identity", username);
  }

  static AppUser? get current => _identityCursor != null
      ? all[_identityCursor]
      : null;

  static String? get accessToken {
    return current?.accessToken;
  }

  static set accessToken(String? value) {
    final idt = current?..accessToken = value;
    if (idt != null) {
      put(idt);
    }
  }

  static String? get organization {
    return current?.organization;
  }

  static void _setAppIdentities(Map<String, AppUser> value) {
    prefs.setString("app_identities",
        json.encode(value.map((key, value) => MapEntry(key, value.toJson()))));
  }

  static String? get _identityCursor => prefs.getString("current_identity");


  static String? get initialPassword => prefs.getString("initial_password");
  static set initialPassword(String? value) => prefs.setString("initial_password", value ?? "");
}
