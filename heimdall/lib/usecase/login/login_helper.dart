import 'dart:convert';
import 'package:chainmetric/platform/repositories/preferences_shared.dart';
import 'package:chainmetric/shared/logger.dart';
import 'package:crypto/crypto.dart';

import 'package:chainmetric/infrastructure/repositories/certificates_vault.dart';
import 'package:chainmetric/infrastructure/services/access_grpc.dart';
import 'package:chainmetric/models/identity/auth.pb.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:grpc/grpc.dart';
import 'package:talos/talos.dart';

class LoginHelper {
  final String _organization;
  final AuthVault _vaultPlugin;

  LoginHelper(this._organization):
        _vaultPlugin = AuthVault(
            "https://vault.${GlobalConfiguration().getValue("grpc_domain")}"
        );

  Future<bool> login(String email, String passcode) async {
    FabricCredentialsResponse resp;

    try {
      resp = await AccessService(_organization,
              certificate: await CertificatesResolver(_organization)
                  .resolveBytes("identity-client"))
          .requestFabricCredentials(FabricCredentialsRequest(
              email: email, passcode: generatePasswordHash(passcode)));
    } on GrpcError catch (e) {
      switch (e.code) {
        case StatusCode.invalidArgument:
          throw Exception(e.message);
        default:
          logger.e("failed request Fabric credentials: [${e.codeName}] ${e.message}");
      }

      return false;
    }

    Preferences.accessToken = resp.apiAccessToken;
    bool success;

    try {
      success = await _vaultPlugin.authenticate(_organization, resp.secret.path, resp.secret.token);
    } on PlatformException catch (e) {
      logger.e("failed to authenticate via Vault: ${e.message}");
      return false;
    }

    return success;
  }

  static String generatePasswordHash(String password) {
    return md5.convert(utf8.encode(password)).toString();
  }
}
