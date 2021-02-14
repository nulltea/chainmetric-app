import 'package:flutter/material.dart';

class LoadingSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    color: Colors.teal,
    child: Center(child: CircularProgressIndicator(backgroundColor: Colors.pinkAccent)),
  );
}