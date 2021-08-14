import 'package:chainmetric/models/identity/auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:yaml/yaml.dart';

const blockchainChannel = "chainmetric.app.blockchain-native-sdk";

class Blockchain {
  static const _nativeSDK = MethodChannel(blockchainChannel);
  static Map<String?, dynamic>? _config;

  static Future<void> initWallet() async {
    final dir = await getApplicationDocumentsDirectory();
    try {
      await _nativeSDK.invokeMethod("wallet_init", {
        "path": "${dir.path}/wallet"
      });
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
  }

  static Future<bool?> authRequired() async {
    try {
      return await _nativeSDK.invokeMethod("auth_required");
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return true;
  }

  static Future<bool> authenticate(AuthCredentials credentials) async {
    try {
      await _nativeSDK.invokeMethod("auth_identity", {
        "orgID": credentials.organization,
        "cert": credentials.certificate,
        "key": credentials.privateKey
      });
      return true;
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return false;
  }

  static Future<bool> initConnection(String channel) async {
    try {
      await _nativeSDK.invokeMethod("connection_init", {
        "config": await getConfigString(),
        "channel": channel
      });
      return true;
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return false;
  }

  static Future<String?> evaluateTransaction(String contract, String method, [String? args]) async {
    try {
      return await _nativeSDK.invokeMethod("transaction_evaluate", {
        "contract": contract,
        "method": method,
        "args": args,
      });
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return null;
  }

  static Future<String?> submitTransaction(String contract, String method, [String? args]) async {
    try {
      return await _nativeSDK.invokeMethod("transaction_submit", {
        "contract": contract,
        "method": method,
        "args": args,
      });
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return null;
  }

  static Future<bool> trySubmitTransaction(String contract, String method, [String? args]) async {
    try {
      await _nativeSDK.invokeMethod("transaction_submit", {
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

  static Future<void> initConfig() async {
    final yaml = loadYaml(
        await rootBundle.loadString("assets/connection.yaml")
    ) as YamlMap;

    _config = { for (var key in yaml.keys) key as String? : yaml[key] };
  }

  static dynamic getConfigValue(String compositeKey) {
    dynamic value = _config;
    for (final key in compositeKey.split(".")) {
      value = value[key];
    }
    return value;
  }

  static Future<String> getConfigString() async {
    final dir = await getApplicationDocumentsDirectory();
    final raw = await rootBundle.loadString("assets/connection.yaml");
    return raw.replaceAll("{keystore-path}", dir.path);
  }
}
