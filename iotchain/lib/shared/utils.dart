import 'package:flutter/material.dart';

void openPage(BuildContext context, Widget page) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page)
);

extension CapExtension on String {
  String get toSentenceCase => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
}