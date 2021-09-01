import 'dart:convert';

import 'package:chainmetric/models/assets/requirements.dart';
import 'package:talos/talos.dart';

class RequirementsController {
  static Future<bool> assignRequirements(Requirements requirements) async {
    final jsonData = json.encode(requirements.toJson());
    return Fabric.trySubmitTransaction("requirements", "Assign", jsonData);
  }

  static Future<bool> revokeRequirements(String? id) async {
    return Fabric.trySubmitTransaction("requirements", "Revoke", id);
  }
}
