import 'package:chainmetric/models/requirements_model.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'blockchain_adapter.dart';

class RequirementsController {
  static Future<bool> assignRequirements(Requirements requirements) async {
    final jsonData = JsonMapper.serialize(requirements);
    return Blockchain.trySubmitTransaction("requirements", "Assign", jsonData);
  }

  static Future<bool> revokeRequirements(String id) async {
    return Blockchain.trySubmitTransaction("requirements", "Revoke", id);
  }
}
