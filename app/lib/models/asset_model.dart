import 'dart:ui';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';
import 'package:chainmetric/models/requirements_model.dart';

import 'location_model.dart';

@jsonSerializable
class Asset {
  String id;
  String sku;
  String name;
  String type;
  String info;
  num cost;
  int amount;
  String holder;
  String state;
  Location location;
  List<String> tags = <String>[];
}

@jsonSerializable
class AssetQuery {
  String type;
  String holder;
  String state;
  String location;
  String tag;
  int limit;
  @JsonProperty(name: "scroll_id")
  String scrollID;

  AssetQuery({
    this.limit,
    this.scrollID,
  });
}

@jsonSerializable
class AssetsResponse {
  List<AssetResponseItem> items = <AssetResponseItem>[];
  @JsonProperty(name: "scroll_id")
  String scrollID;
}

@jsonSerializable
class AssetResponseItem extends Asset {
  Requirements requirements;
  Requirements getRequirements() {
    return requirements ?? Requirements.forAsset(assetID: id);
  }
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
