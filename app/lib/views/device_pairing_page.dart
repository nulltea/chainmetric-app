import 'package:chainmetric/views/components/ripple_animation.dart';
import 'package:flutter/material.dart';

class DevicePairing extends StatefulWidget {
  @override
  _DevicePairingState createState() => _DevicePairingState();
}

class _DevicePairingState extends State<DevicePairing> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Ripples(
      child: Icon(Icons.search),
  );
}
