import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class Privileges {
  static late Map<String, dynamic> _data;

  static Future init({Map<String, dynamic>? fromJson}) async {
    _data = fromJson ?? json.decode(await rootBundle.loadString("assets/data/user_privileges.json"));
  }

  static bool resolveFor(String privilegePath) {
    dynamic value = _data;
    for (final key in privilegePath.split(".")) {
      value = value[key];
    }
    return value;
  }
}