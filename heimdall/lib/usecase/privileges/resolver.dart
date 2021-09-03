import 'dart:convert';

import 'package:chainmetric/models/identity/user.dart';
import 'package:flutter/services.dart' show rootBundle;

class Privileges {
  static late Map<String, dynamic> _data;

  static Future init({Map<String, dynamic>? fromJson}) async {
    _data = fromJson ?? json.decode(await rootBundle.loadString("assets/data/user_privileges.json"));
  }

  static bool resolveFor(AppUser user, String path) {
    dynamic value = _data;

    for (final key in List.from(path.split("."))
      ..insert(0, user.role)) {
      value = value?[key];
    }

    return value ?? false;
  }
}