import 'package:chainmetric/models/assets/requirements.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:chainmetric/platform/adapters/hyperledger_adapter.dart';

class RequirementsController {
  static Future<bool> assignRequirements(Requirements? requirements) async {
    final jsonData = JsonMapper.serialize(requirements);
    return Hyperledger.trySubmitTransaction("requirements", "Assign", jsonData);
  }

  static Future<bool> revokeRequirements(String? id) async {
    return Hyperledger.trySubmitTransaction("requirements", "Revoke", id);
  }
}
