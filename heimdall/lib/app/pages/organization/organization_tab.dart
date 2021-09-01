import 'package:chainmetric/app/pages/identity/login_page.dart';
import 'package:chainmetric/app/utils/utils.dart' as utils;
import 'package:chainmetric/app/widgets/common/modal_menu.dart';
import 'package:chainmetric/platform/repositories/identities_shared.dart';
import 'package:chainmetric/usecase/identity/identity_manager.dart';
import 'package:flutter/material.dart';
import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/app/widgets/common/navigation_tab.dart';
import 'package:chainmetric/models/identity/user.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class OrganizationTab extends NavigationTab {
  final Function? reloadApp;

  const OrganizationTab({Key? key, this.reloadApp}) : super(key: key);

  _ProfileTabState? get _currentState =>
      (key as GlobalKey?)?.currentState as _ProfileTabState?;

  @override
  _ProfileTabState createState() => _ProfileTabState();

  @override
  Future? refreshData() => _currentState!._refreshData();
}

class _ProfileTabState extends State<OrganizationTab> {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

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
        body: RefreshIndicator(
          key: _refreshKey,
          onRefresh: _refreshData,
          child: const Center(
            child: Text("Profile here"),
          ),
        ),
      );

  void _showMenu(BuildContext context) {
    showModalMenu(context: context, options: [
      ModalMenuOption(
        title: "Add identity",
        icon: Icons.person_add_sharp,
        action: () =>
            utils.openPage(context, LoginPage(onLogged: widget.reloadApp)),
      ),
      ModalMenuOption(
        title: "Switch identity",
        icon: Icons.contacts_sharp,
        action: () => _switchIdentitiesMenu(context),
      ),
      ModalMenuOption(
          title: "Log out",
          icon: Icons.logout_sharp,
          action: () => IdentityManager.forget(IdentitiesRepo.current!.username,
              then: widget.reloadApp)),
    ]);
  }

  void _switchIdentitiesMenu(BuildContext context) {
    showModalMenu(context: context, options: [
      for (final identity in IdentitiesRepo.all.values)
        ModalMenuOption(
            title: identity.user?.fullName ?? identity.username.split("@")[0],
            subtitle: identity.organization,
            icon: Icons.contacts_sharp,
            action: () =>
                IdentityManager.use(identity.username, then: widget.reloadApp)),
      ModalMenuOption(
        title: "Add new",
        icon: Icons.person_add_sharp,
        action: () =>
            utils.openPage(context, LoginPage(onLogged: widget.reloadApp)),
      ),
    ]);
  }

  Future _refreshData() {
    return Future.value();
  }
}
