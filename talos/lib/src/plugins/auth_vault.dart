import 'package:flutter/services.dart';

const vaultChannel = "network.chainmetric.talos/plugins/auth_vault";

class AuthVault {
  static const _channel = MethodChannel(vaultChannel);

  static Future<bool> authenticate(String organization, String secretPath, String secretToken) async {
    try {
      await _channel.invokeMethod("authenticate", {
        "orgID": organization,
        "path": secretPath,
        "token": secretToken
      });
      return true;
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    }
    return false;
  }
}