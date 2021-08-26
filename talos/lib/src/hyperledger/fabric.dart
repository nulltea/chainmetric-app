import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talos/src/hyperledger/config.dart';

const hyperledgerChannel = "network.chainmetric.talos/hyperledger";

class Hyperledger {
  static const _channel = MethodChannel(hyperledgerChannel);

  static Future<void> initWallet() async {
    final dir = await getApplicationDocumentsDirectory();
    try {
      await _channel
          .invokeMethod("wallet_init", {"path": "${dir.path}/wallet"});
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
  }

  static Future<bool> authRequired() async {
    try {
      return await _channel.invokeMethod("auth_required");
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return true;
  }

  static Future<bool> authenticate(String organization, String certificate, String key) async {
    try {
      await _channel.invokeMethod("auth_identity", {
        "orgID": organization,
        "cert": certificate,
        "key": key
      });
      return true;
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return false;
  }

  static Future<bool> initConnection(FabricConnection conn, String channel) async {
    try {
      await _channel.invokeMethod("connection_init",
          {"config": conn.toString(), "channel": channel});
      return true;
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return false;
  }

  static Future<String?> evaluateTransaction(String contract, String method,
      [String? args]) async {
    try {
      return await _channel.invokeMethod("transaction_evaluate", {
        "contract": contract,
        "method": method,
        "args": args,
      });
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return null;
  }

  static Future<String?> submitTransaction(String contract, String method,
      [String? args]) async {
    try {
      return await _channel.invokeMethod("transaction_submit", {
        "contract": contract,
        "method": method,
        "args": args,
      });
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return null;
  }

  static Future<bool> trySubmitTransaction(String contract, String method,
      [String? args]) async {
    try {
      await _channel.invokeMethod("transaction_submit", {
        "contract": contract,
        "method": method,
        "args": args,
      });
      return true;
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return false;
  }
}
