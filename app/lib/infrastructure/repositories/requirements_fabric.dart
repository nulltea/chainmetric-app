import 'package:chainmetric/models/assets/requirements.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../../platform/adapters/blockchain_adapter.dart';

class RequirementsController {
  static Future<bool> assignRequirements(Requirements? requirements) async {
    final jsonData = JsonMapper.serialize(requirements);
    return Blockchain.trySubmitTransaction("requirements", "Assign", jsonData);
  }

  static Future<bool> revokeRequirements(String? id) async {
    return Blockchain.trySubmitTransaction("requirements", "Revoke", id);
  }
}
