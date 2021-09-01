
import 'package:chainmetric/platform/repositories/identities_shared.dart';
import 'package:chainmetric/shared/logger.dart';
import 'package:flutter/services.dart';
import 'package:talos/talos.dart';

class IdentityManager {
  static Future<void> forget(String username, {Function? then}) async {
    try {
      await Fabric.removeIdentity(username: username);
    } on PlatformException catch (e) {
      logger.e("failed to remove identity: ${e.message}");
      return;
    }

    IdentitiesRepo.del(username);
    then?.call();
  }

  static void use(String username, {Function? then}) {
    IdentitiesRepo.setCurrent(username);
    then?.call();
  }
}