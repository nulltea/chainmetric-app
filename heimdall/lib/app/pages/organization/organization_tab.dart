import 'package:chainmetric/app/widgets/common/modal_menu.dart';
import 'package:chainmetric/platform/repositories/appidentities_shared.dart';
import 'package:flutter/material.dart';
import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/app/widgets/common/navigation_tab.dart';
import 'package:talos/talos.dart';

class ProfileTab extends NavigationTab {
  ProfileTab({GlobalKey? key}) : super(key: key ?? GlobalKey());

  _ProfileTabState? get _currentState =>
      (key as GlobalKey?)?.currentState as _ProfileTabState?;

  @override
  _ProfileTabState createState() => _ProfileTabState();

  @override
  Future? refreshData() => _currentState!._refreshData();
}

class _ProfileTabState extends State<ProfileTab> {
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
        icon: Icons.person_add,
        action: () => throw UnimplementedError(),
      ),
      ModalMenuOption(
        title: "Log out",
        icon: Icons.logout,
        action: () {
          Fabric.removeIdentity(username: AppIdentities.current!.username);
          Navigator.of(context).build(context);
        },
      ),
    ]);
  }

  Future _refreshData() {
    return Future.value();
  }
}
