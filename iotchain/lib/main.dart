
import 'package:iotchain/controllers/blockchain_adapter.dart';
import 'package:iotchain/views/auth_page.dart';
import 'package:iotchain/views/components/loading_splash.dart';

import 'views/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  // initializeJsonMapper();
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
      title: 'IoTChain client app',
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
