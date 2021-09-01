import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

const vaultChannel = "network.chainmetric.talos/plugins/vault_authenticator";

class VaultAuthenticator {
  static const _channel = MethodChannel(vaultChannel);
  static final _logger = Logger(
    printer: PrettyPrinter(),
  );

  VaultAuthenticator(String address, {String defaultToken = ""}) {
    try {
      _channel.invokeMethod("init", {
        "address": address,
        "default_token": defaultToken,
      });
    } on PlatformException catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<bool> fetchVaultIdentity(
      String organization,
      String secretPath,
      String secretToken,
      {String username = "appUser"}
  ) async {
    return await _channel.invokeMethod<int>("identity_fetch", {
      "username": username,
      "org": organization,
      "path": secretPath,
      "token": secretToken,
    }) == 0;
  }
}