import 'package:chainmetric/app/pages/identity/login_page.dart';
import 'package:chainmetric/app/widgets/common/modal_menu.dart';
import 'package:chainmetric/platform/repositories/identities_shared.dart';
import 'package:chainmetric/usecase/identity/identity_manager.dart';
import 'package:flutter/material.dart';
import 'package:chainmetric/app/utils/utils.dart' as utils;

void switchIdentitiesMenu(BuildContext context, {Function(BuildContext)? onSelect}) {
  showModalMenu(context: context, options: [
    for (final identity in IdentitiesRepo.all.values)
      ModalMenuOption(
          title: identity.displayName,
          subtitle: identity.organization,
          icon: Icons.contacts_sharp,
          action: () =>
              IdentityManager.use(identity.username, then: () => onSelect?.call(context))),
    ModalMenuOption(
      title: "Add new",
      icon: Icons.person_add_sharp,
      action: () =>
          utils.openPage(context, LoginPage(onLogged: onSelect)),
    ),
  ]);
}