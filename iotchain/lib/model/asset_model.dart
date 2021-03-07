import 'dart:ui';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';

@jsonSerializable
class Asset {
  String id;
  String sku;
  String name;
  String type;
  String info;
  num cost;
  int amount;
  String owner;
  String state;
  String location;
  List<String> tags = <String>[];
}

@jsonSerializable
class AssetType {
  String name;
  String type;
  @JsonProperty(name: "color_hex")
  String colorHex;
  Color get color => colorFromHex(colorHex);

  Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse("FF$hexCode", radix: 16));
  }
}