import 'package:iotchain/controllers/blockchain_adapter.dart';

import 'views/home.dart';
import 'package:flutter/material.dart';



void main() async {
  Blockchain.initWallet();
  if(await Blockchain.authRequired()) {
    // Auth();
  }
  Blockchain.initConnection("supply-channel");
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoTChain client app',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      darkTheme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

