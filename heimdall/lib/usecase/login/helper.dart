import 'dart:convert';
import 'package:chainmetric/platform/repositories/preferences_shared.dart';
import 'package:crypto/crypto.dart';

import 'package:chainmetric/infrastructure/repositories/certificates_vault.dart';
import 'package:chainmetric/infrastructure/services/auth_grpc.dart';
import 'package:chainmetric/models/identity/auth.pb.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:talos/talos.dart';

class LoginHelper {
  final String _organization;
  final _logger = Logger('LoginHelper');

  LoginHelper(this._organization);

  Future<bool> login(String email, String passcode) async {
    AuthResponse resp;

    try {
      resp = await AuthService(_organization,
              certificate: await CerificatesResolver(_organization)
                  .resolveBytes("identity-client"))
          .authenticate(AuthRequest(
              email: email, passwordHash: generatePasswordHash(passcode)));
    } on Exception {
      return false;
    }

    Preferences.accessToken = resp.accessToken;
    bool success;

    try {
      success = await AuthVault.authenticate(_organization, resp.secret.path, resp.secret.token);
    } on PlatformException catch (e) {
      _logger.severe("failed to authificate via Vault: ${e.toString()}");
      return false;
    }

    return success;
  }

  static String generatePasswordHash(String password) {
    return md5.convert(utf8.encode(password)).toString();
  }
}
