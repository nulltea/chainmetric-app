import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:iotchain/model/asset_model.dart';

import 'blockchain_adapter.dart';

class AssetsController {
  static Future<AssetsResponse> getAssets({AssetQuery query, int limit, String scrollID}) async {
    query ??= AssetQuery(limit: limit, scrollID: scrollID);
    String data = await Blockchain.evaluateTransaction(
        "assets", "Query", JsonMapper.serialize(query));
    try {
      return data.isNotEmpty
          ? JsonMapper.deserialize<AssetsResponse>(data)
          : AssetsResponse();
    } on Exception catch (e) {
      print(e.toString());
    }
    return AssetsResponse();
  }

  static Future<bool> upsertAsset(String id) async {
    return await Blockchain.trySubmitTransaction("assets", "Insert", id);
  }

  static Future<bool> deleteAsset(String id) async {
    return await Blockchain.trySubmitTransaction("assets", "Remove", id);
  }
}