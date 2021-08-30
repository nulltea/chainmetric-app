import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

const vaultChannel = "network.chainmetric.talos/plugins/auth_vault";

class AuthVault {
  static const _channel = MethodChannel(vaultChannel);
  static final _logger = Logger(
    printer: PrettyPrinter(),
  );

  AuthVault(String address, {String defaultToken = ""}) {
    try {
      _channel.invokeMethod("init", {
        "address": address,
        "default_token": defaultToken,
      });
    } on PlatformException catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<bool> authenticate(String organization, String secretPath, String secretToken) async {
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