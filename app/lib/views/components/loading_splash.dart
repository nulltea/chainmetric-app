import 'package:flutter/material.dart';

class LoadingSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    color: Colors.black54,
    child: Center(
        child: CircularProgressIndicator.adaptive(backgroundColor: Colors.teal)
    ),
  );
}
