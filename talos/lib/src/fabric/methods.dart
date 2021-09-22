import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talos/src/fabric/config.dart';

const hyperledgerChannel = "network.chainmetric.talos/hyperledger";

class Fabric {
  static const _channel = MethodChannel(hyperledgerChannel);
  static final _logger = Logger(
    printer: PrettyPrinter(),
  );

  static Future<void> initWallet() async {
    final dir = await getApplicationDocumentsDirectory();
    return _channel.invokeMethod("wallet_init", {"path": "${dir.path}/wallet"});
  }

  static Future<bool> identityExists({String username = "appUser"}) async =>
      await _channel.invokeMethod<bool>("identity_exists", {"username": username}) ?? true;

  static Future<List<String>> getIdentities() async {
    try {
      final identities = await _channel.invokeMethod<String>("identities_get");
      return identities != null
          ? identities.split(",")
          : <String>[];
    } on PlatformException catch (e) {
      _logger.e("PlatformException: ${e.message}");
      return <String>[];
    }
  }

  static Future<void> putX509Identity(
      String organization,
      String certificate, String signingKey, {String username = "appUser"}
  ) => _channel.invokeMethod("identity_put", {
      "username": username,
      "org": organization,
      "cert": certificate,
      "key": signingKey,
    });

  static Future<void> removeIdentity({String username = "appUser"}) =>
      _channel.invokeMethod("identity_remove", {"username": username});

  static Future<bool> setupConnection(
      FabricConnection conn,
      String channel, {String username = "appUser"}
  ) async {
    return await _channel.invokeMethod<int>("connection_setup", {
      "config": conn.toString(),
      "channel": channel,
      "username": username,
    }) == 0;
  }

  static Future<String?> evaluateTransaction(String contract, String method,
      [dynamic args]) async {
    try {
      return await _channel.invokeMethod("transaction_evaluate", {
        "contract": contract,
        "method": method,
        "args": json.encode(args),
      });
    } on PlatformException catch (e) {
      throw Exception("go error: ${e.message}");
    } on JsonUnsupportedObjectError {
      throw Exception("Unsupported method argument types, they must be encodable");
    }
  }

  static Future<String?> submitTransaction(
      String contract, String method, [dynamic args]
  ) {
    try {
    return _channel.invokeMethod<String>("transaction_submit", {
      "contract": contract,
      "method": method,
      "args": json.encode(args),
    });
    } on PlatformException catch (e) {
      throw Exception("go error: ${e.toString()}");
    } on JsonUnsupportedObjectError {
      throw Exception("Unsupported method argument types, they must be encodable");
    }
  }

  static Future<bool> trySubmitTransaction(String contract, String method,
      [dynamic args]) async {
    try {
      await _channel.invokeMethod("transaction_submit", {
        "contract": contract,
        "method": method,
        "args": json.encode(args),
      });
      return true;
    } on PlatformException catch (e) {
      _logger.w(e);
      return false;
    } on JsonUnsupportedObjectError {
      throw Exception("Unsupported method argument types, they must be encodable");
    }
  }
}
