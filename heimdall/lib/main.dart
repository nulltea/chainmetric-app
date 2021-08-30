import 'dart:async';

import 'package:chainmetric/app/pages/identity/login_page.dart';
import 'package:chainmetric/app/pages/main_page.dart';
import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/app/widgets/common/loading_splash.dart';
import 'package:chainmetric/platform/adapters/bluetooth.dart';
import 'package:chainmetric/platform/repositories/appidentities_shared.dart';
import 'package:chainmetric/platform/repositories/localdata_json.dart';
import 'package:chainmetric/platform/repositories/paired_devices_shared.dart';
import 'package:chainmetric/usecase/privileges/resolver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:global_configuration/global_configuration.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:talos/talos.dart';
import 'package:yaml/yaml.dart';

void main() {
  runApp(App());
}

Future<void> initConfig() async {
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
      home: _isLoading
          ? LoadingSplash()
          : _requireAuth
              ? LoginPage(submitAuth: _initBackend)
              : MainPage(),
    );
  }

  @override
  void initState() {
    super.initState();
    initConfig();
    _initBackend();
    _initOverlay();
  }

  Future<void> _initBackend() async {
    await PairedDevices.init();
    await AppIdentities.init();
    await LocalData.init();
    await Privileges.init();
    await Fabric.initWallet();
    if (await Fabric.identityRequired()) {
      setState(() => _isLoading = false);
      return;
    }
    final config = await FabricConnection("assets/connection.yaml", AppIdentities.organization!).init();
    await Fabric.setupConnection(config, "supply-channel", username: AppIdentities.current!.username);
    setState(() => _requireAuth = _isLoading = false);

    await Bluetooth.init();
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
}
