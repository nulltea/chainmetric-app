import 'dart:async';

import 'package:chainmetric/app/pages/identity/confirm_pending_page.dart';
import 'package:chainmetric/app/pages/identity/login_page.dart';
import 'package:chainmetric/app/pages/main_page.dart';
import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/app/widgets/common/loading_splash.dart';
import 'package:chainmetric/platform/adapters/bluetooth.dart';
import 'package:chainmetric/platform/repositories/identities_shared.dart';
import 'package:chainmetric/platform/repositories/localdata_json.dart';
import 'package:chainmetric/platform/repositories/paired_devices_shared.dart';
import 'package:chainmetric/usecase/notifications/notifications_manager.dart';
import 'package:chainmetric/usecase/privileges/resolver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:global_configuration/global_configuration.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:talos/talos.dart';
import 'package:yaml/yaml.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  runApp(App());
}

Future<void> _initConfig() async {
  final yaml = loadYaml(await rootBundle.loadString("assets/config.yaml"));

  GlobalConfiguration()
      .loadFromMap({for (var key in yaml.keys) (key as String?)!: yaml[key]});
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _requireAuth = true;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chainmetric admin application",
      theme: AppTheme.themeData,
      darkTheme: AppTheme.themeData,
      home: _viewApp(),
    );
  }

  Widget? _viewApp() {
    if (_isLoading) {
      return LoadingSplash();
    }

    if (_requireAuth) {
      final pendingConfirm = IdentitiesRepo.current?.confirmed == false;

      return pendingConfirm
          ? ConfirmPendingPage(onReady: _reloadApp)
          : LoginPage(onLogged: _reloadApp);
    }

    return MainPage(reloadApp: _reloadApp);
  }

  @override
  void initState() {
    super.initState();
    _initConfig();
    _initBackend();
    _initOverlay();
  }

  Future<void> _initBackend() async {
    await IdentitiesRepo.init();
    await PairedDevicesRepo.init();
    await LocalDataRepo.init();
    await Privileges.init();
    await Fabric.initWallet();
    await NotificationsManager.registerDriver();

    final identity = IdentitiesRepo.current;

    if (identity == null || await Fabric.identityExists(username: identity.username)) {
      setState(() => _isLoading = false);
      return;
    }

    final config = await FabricConnection(
            "assets/connection.yaml", IdentitiesRepo.organization!)
        .init();
    await Fabric.setupConnection(config, "supply-channel",
        username: IdentitiesRepo.current!.username);
    await Bluetooth.init();
    setState(() => _requireAuth = _isLoading = false);
  }

  void _initOverlay() {
    OverlayScreen().saveScreens({
      "modal": CustomOverlayScreen(
        backgroundColor: AppTheme.primaryBG.withAlpha(225),
        content: const Center(),
      ),
      "loading": CustomOverlayScreen(
        backgroundColor: AppTheme.primaryBG.withAlpha(225),
        content: LoadingBouncingGrid.square(
            size: 75,
            backgroundColor: Colors.teal.shade600,
            borderColor: Colors.black54),
      ),
    });
  }

  void _reloadApp(BuildContext context) {
    Navigator.maybePop(context);
    _requireAuth = true;
    _initBackend();
  }
}
