import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:iotchain/model/device_model.dart';
import 'package:iotchain/model/metric_model.dart';
import 'package:iotchain/model/requirements_model.dart';

import 'controllers/references_adapter.dart';
import 'main.reflectable.dart';
import 'package:iotchain/controllers/blockchain_adapter.dart';
import 'package:iotchain/views/auth_page.dart';
import 'package:iotchain/views/components/loading_splash.dart';

import 'model/asset_model.dart';
import 'model/organization_model.dart';
import 'views/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  initJson();
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
    initBackend();
  }

  Future initBackend() async {
    await References.init();
    await Blockchain.initWallet();
    if (await Blockchain.authRequired()) {
      setState(() => _isLoading = false);
      return;
    }
    await Blockchain.initConnection("supply-channel");
    setState(() => _requireAuth = _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "IoTChain client app",
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      darkTheme: ThemeData.dark(),
      home: _isLoading
          ? LoadingSplash()
          : _requireAuth
              ? AuthPage(submitAuth: initBackend,)
              : HomePage(),
    );
  }
}

void initJson() {
  initializeReflectable();
  JsonMapper().useAdapter(JsonMapperAdapter(
      valueDecorators: {
        typeOf<List<String>>(): (value) => value.cast<String>(),
        typeOf<List<Asset>>(): (value) => value.cast<Asset>(),
        typeOf<List<Device>>(): (value) => value.cast<Device>(),
        typeOf<List<Organization>>(): (value) => value.cast<Organization>(),
        typeOf<List<AssetType>>(): (value) => value.cast<AssetType>(),
        typeOf<List<DeviceProfile>>(): (value) => value.cast<DeviceProfile>(),
        typeOf<List<Metric>>(): (value) => value.cast<Metric>(),
        typeOf<Map<String, Requirement>>(): (value) => Map<String, Requirement>.from(value),
      })
  );
}
