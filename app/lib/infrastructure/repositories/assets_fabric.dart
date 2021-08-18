import 'package:chainmetric/models/assets/asset.dart';
import 'package:chainmetric/platform/adapters/hyperledger_adapter.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class AssetsController {
  static Future<AssetsResponse?> getAssets({AssetsQuery? query, int? limit, String? scrollID}) async {
    query ??= AssetsQuery(limit: limit, scrollID: scrollID);
    final data = await Hyperledger.evaluateTransaction(
        "assets", "Query", JsonMapper.serialize(query));
    try {
      return data != null && data.isNotEmpty
          ? JsonMapper.deserialize<AssetsResponse>(data)
          : AssetsResponse();
    } on Exception catch (e) {
      print(e.toString());
    }
    return AssetsResponse();
  }

  static Future<bool> upsertAsset(Asset asset) async {
    final jsonData = JsonMapper.serialize(asset);
    return Hyperledger.trySubmitTransaction("assets", "Upsert", jsonData);
  }

  static Future<bool> deleteAsset(String? id) async {
    return Hyperledger.trySubmitTransaction("assets", "Remove", id);
  }
}
