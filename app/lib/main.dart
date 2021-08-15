import 'dart:async';

import 'package:chainmetric/platform/adapters/blockchain_adapter.dart';
import 'package:chainmetric/platform/adapters/bluetooth_adapter.dart';
import 'package:chainmetric/platform/repositories/preferences_repo.dart';
import 'package:chainmetric/infrastructure/repositories/references_fabric.dart';
import 'package:chainmetric/main.reflectable.dart';
import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/models/assets/asset.dart';
import 'package:chainmetric/models/device/device.dart';
import 'package:chainmetric/models/readings/metric.dart';
import 'package:chainmetric/models/identity/organization.dart';
import 'package:chainmetric/models/readings/readings.dart';
import 'package:chainmetric/models/assets/requirements.dart';
import 'package:chainmetric/app/widgets/common/loading_splash.dart';
import 'package:chainmetric/app/pages/main_page.dart';
import 'package:chainmetric/app/pages/auth/page.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:global_configuration/global_configuration.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:yaml/yaml.dart';


void main() {
  init();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _requireAuth = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    initConfig();
    _initBackend();
    _initOverlay();
  }

  ThemeData mainTheme() => darkTheme;

  ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    backgroundColor: AppTheme.primaryBG,
    scaffoldBackgroundColor: AppTheme.primaryBG,
    primaryColor: AppTheme.primaryColor,
    bottomAppBarTheme: ThemeData.dark().bottomAppBarTheme.copyWith(
      color: AppTheme.appBarBG,
    ),
    textTheme: ThemeData.dark().textTheme.copyWith(
      headline1: AppTheme.title1,
      headline2: AppTheme.title2,
      headline3: AppTheme.title3,
      subtitle1: AppTheme.subtitle1,
      subtitle2: AppTheme.subtitle2,
      bodyText1: AppTheme.bodyText1,
      bodyText2: AppTheme.bodyText1,
    ),
    cardColor: AppTheme.cardBG,
    inputDecorationTheme: ThemeData.dark().inputDecorationTheme.copyWith(
      fillColor: AppTheme.inputBG,
      hintStyle: AppTheme.subtitle2.copyWith(color: ThemeData.dark().hintColor),
      labelStyle: AppTheme.subtitle1,
      helperStyle: AppTheme.subtitle2,
    ),
    appBarTheme: ThemeData.dark().appBarTheme.copyWith(
      backgroundColor: AppTheme.primaryColor,
      actionsIconTheme: ThemeData.dark().iconTheme,
      titleTextStyle: AppTheme.title2.override(fontFamily: "IBM Plex Mono", fontSize: 28),
    )
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chainmetric admin application",
      theme: mainTheme(),
      darkTheme: darkTheme,
      home: _isLoading
          ? LoadingSplash()
          : _requireAuth
              ? AuthPage(submitAuth: _initBackend)
              : MainPage(),
    );
  }

  Future<void> _initBackend() async {
    await Preferences.init();
    await References.init();
    await Blockchain.initWallet();
    if (await (Blockchain.authRequired() as FutureOr<bool>)) {
      setState(() => _isLoading = false);
      return;
    }
    await Blockchain.initConnection("supply-channel");
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
        backgroundColor: darkTheme.primaryColor.withAlpha(225),
        content: LoadingBouncingGrid.square(
            size: 75,
            backgroundColor: Colors.teal.shade600,
            borderColor: Colors.black54
        ),
      ),
    });
  }
}

void init() {
  initJson();
}

Future<void> initConfig() async {
  final yaml = loadYaml(
      await rootBundle.loadString("assets/config.yaml")
  );

  GlobalConfiguration().loadFromMap(
    { for (var key in yaml.keys) (key as String?)! : yaml[key] }
  );
}

/// deprecated
void initJson() {
  initializeReflectable();
  JsonMapper().useAdapter(JsonMapperAdapter(
      valueDecorators: {
        typeOf<List<String>>(): (value) => value.cast<String>(),
        typeOf<List<Asset>>(): (value) => value.cast<Asset>(),
        typeOf<List<AssetPresenter>>(): (value) => value.cast<AssetPresenter>(),
        typeOf<List<Device>>(): (value) => value.cast<Device>(),
        typeOf<List<Organization>>(): (value) => value.cast<Organization>(),
        typeOf<List<AssetType>>(): (value) => value.cast<AssetType>(),
        typeOf<List<DeviceProfile>>(): (value) => value.cast<DeviceProfile>(),
        typeOf<List<Metric>>(): (value) => value.cast<Metric>(),
        typeOf<Map<String, Requirement>>(): (value) => Map<String, Requirement>.from(value as Map),
        typeOf<Map<String, List<MetricReadingPoint>>>(): (value) => Map<String, List<MetricReadingPoint>>.from(value as Map),
        typeOf<List<MetricReadingPoint>>(): (value) => value.cast<MetricReadingPoint>(),
        typeOf<MetricReadingsStream>(): (value) => MetricReadingsStream.from(value.cast<MetricReadingPoint>().toList() as List<MetricReadingPoint?>?),
        typeOf<List<DeviceCommandLogEntry>>(): (value) => value.cast<DeviceCommandLogEntry>(),
        typeOf<Map<String, PairedDevice>>(): (value) => Map<String, PairedDevice>.from(value as Map),
      },
    enumValues: {
        DeviceCommand: EnumDescriptor(
            values: DeviceCommand.values,
            mapping: <DeviceCommand, String>{
              DeviceCommand.pause: "pause",
              DeviceCommand.resume: "resume",
              DeviceCommand.pairBluetooth: "ble_pair"
            }
        ),
    })
  );
}
