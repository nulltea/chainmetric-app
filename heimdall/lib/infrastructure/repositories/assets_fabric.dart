import 'dart:convert';

import 'package:chainmetric/models/assets/asset.dart';
import 'package:chainmetric/shared/logger.dart';
import 'package:talos/talos.dart';

class AssetsController {
  static Future<AssetsResponse?> getAssets(
      {AssetsQuery? query, int? limit, String? scrollID}) async {
    query ??= AssetsQuery(limit: limit, scrollID: scrollID);
    try {
      final data = await Fabric.evaluateTransaction(
          "assets", "Query", json.encode(query.toJson()));
      return data != null && data.isNotEmpty
          ? AssetsResponse.fromJson(json.decode(data))
          : AssetsResponse();
    } on Exception catch (e) {
      logger.e(e);
    }
    return AssetsResponse();
  }

  static Future<bool> upsertAsset(Asset asset) async {
    final jsonData = json.encode(asset.toJson());
    return Fabric.trySubmitTransaction("assets", "Upsert", jsonData);
  }

  static Future<bool> deleteAsset(String? id) async {
    return Fabric.trySubmitTransaction("assets", "Remove", id);
  }
}
