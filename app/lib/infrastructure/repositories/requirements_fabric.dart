import 'dart:convert';

import 'package:chainmetric/models/assets/requirements.dart';
import 'package:chainmetric/platform/adapters/hyperledger.dart';

class RequirementsController {
  static Future<bool> assignRequirements(Requirements requirements) async {
    final jsonData = json.encode(requirements.toJson());
    return Hyperledger.trySubmitTransaction("requirements", "Assign", jsonData);
  }

  static Future<bool> revokeRequirements(String? id) async {
    return Hyperledger.trySubmitTransaction("requirements", "Revoke", id);
  }
}
