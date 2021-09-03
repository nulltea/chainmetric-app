import 'package:chainmetric/app/pages/identity/login_page.dart';
import 'package:chainmetric/app/pages/organization/candidates_page.dart';
import 'package:chainmetric/app/utils/utils.dart' as utils;
import 'package:chainmetric/app/utils/menus.dart' as menus;
import 'package:chainmetric/app/widgets/common/modal_menu.dart';
import 'package:chainmetric/models/identity/user.dart';
import 'package:chainmetric/platform/repositories/identities_shared.dart';
import 'package:chainmetric/platform/repositories/localdata_json.dart';
import 'package:chainmetric/usecase/identity/identity_manager.dart';
import 'package:chainmetric/usecase/privileges/resolver.dart';
import 'package:flutter/material.dart';
import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/app/widgets/common/navigation_tab.dart';

class OrganizationTab extends NavigationTab {
  final Function(BuildContext)? reloadApp;

  const OrganizationTab({Key? key, this.reloadApp}) : super(key: key);

  _ProfileTabState? get _currentState =>
      (key as GlobalKey?)?.currentState as _ProfileTabState?;

  @override
  _ProfileTabState createState() => _ProfileTabState();

  @override
  Future? refreshData() => Future.value();
}

class _ProfileTabState extends State<OrganizationTab> {
  late final AppUser user;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Your organization",
              style: AppTheme.title2
                  .override(fontFamily: "IBM Plex Mono", fontSize: 28)),
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 4,
          actions: [
            IconButton(
                onPressed: () => _showMenu(context),
                icon: const Icon(Icons.menu))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Center(child: Icon(Icons.account_circle_sharp, size: 128)),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("${user.firstname} ${user.lastname}",
                    style: AppTheme.title1),
              ),
            ),
            Center(
                child: Text(LocalDataRepo.organizationsMap[user.organization]!.name,
                    style:
                        AppTheme.subtitle1.override(
                          fontFamily: "Roboto Mono",
                            color: AppTheme.hintColor)))
          ]),
        ),
      );

  void _showMenu(BuildContext context) {
    showModalMenu(context: context, options: [
      if (Privileges.resolveFor(IdentitiesRepo.current!, "identity.enroll"))
        ModalMenuOption(
          title: "Enroll users",
          icon: Icons.manage_accounts_sharp,
          action: () => utils.openPage(context, const CandidatesPage()),
        ),
      ModalMenuOption(
        title: "Add identity",
        icon: Icons.person_add_sharp,
        action: () =>
            utils.openPage(context, LoginPage(onLogged: widget.reloadApp)),
      ),
      ModalMenuOption(
        title: "Switch identity",
        icon: Icons.contacts_sharp,
        action: () =>
            menus.switchIdentitiesMenu(context, onSelect: widget.reloadApp),
      ),
      ModalMenuOption(
          title: "Log out",
          icon: Icons.logout_sharp,
          action: () => IdentityManager.forget(IdentitiesRepo.current!.username,
              then: () => widget.reloadApp?.call(context))),
    ]);
  }

  @override
  void initState() {
    super.initState();
    user = IdentitiesRepo.current!;
  }
}
