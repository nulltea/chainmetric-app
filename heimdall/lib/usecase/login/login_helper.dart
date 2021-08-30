import 'dart:convert';
import 'package:chainmetric/models/identity/app_identity.dart';
import 'package:chainmetric/platform/repositories/appidentities_shared.dart';
import 'package:chainmetric/shared/logger.dart';
import 'package:crypto/crypto.dart';

import 'package:chainmetric/infrastructure/repositories/certificates_vault.dart';
import 'package:chainmetric/infrastructure/services/access_grpc.dart';
import 'package:chainmetric/models/identity/auth.pb.dart';
import 'package:chainmetric/models/identity/user.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:grpc/grpc.dart';
import 'package:talos/talos.dart';

class LoginHelper {
  final String _organization;
  final VaultAuthenticator _vaultPlugin;

  LoginHelper(this._organization): _vaultPlugin = VaultAuthenticator(
      "https://vault.infra.${GlobalConfiguration().getValue("grpc_domain")}"
  );

  Future<bool> loginUserpass(String email, String passcode) async {
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

    bool success;

    try {
      success = await _vaultPlugin.fetchVaultIdentity(_organization,
          resp.secret.path,
          resp.secret.token,
          username: resp.user.username,
      );
    } on PlatformException catch (e) {
      logger.e("failed to authenticate via Vault: ${e.message}");
      return false;
    }

    AppIdentities.put(
        AppIdentity(_organization, resp.user.username,
            accessToken: resp.apiAccessToken)
    );
    AppIdentities.setCurrent(resp.user.username);

    return success;
  }

  Future<bool> loginX509(String cert, String key) async {
    // TODO: Preferences.accessToken = ??;

    const username = "admin";

    try {
      await Fabric.putX509Identity(_organization, cert, key, username: username);
    } on PlatformException catch (e) {
      logger.e("failed to put x509 identity: ${e.message}");
      return false;
    }

    AppIdentities.put(AppIdentity(_organization, username));
    AppIdentities.setCurrent(username);

    return true;
  }

  Future<void> logout(String username) async {
    try {
      await Fabric.removeIdentity(username: username);
    } on PlatformException catch (e) {
      logger.e("failed to remove identity: ${e.message}");
      return;
    }

    AppIdentities.del(username);
  }

  static String generatePasswordHash(String password) {
    return md5.convert(utf8.encode(password)).toString();
  }
}
