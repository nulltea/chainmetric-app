import 'dart:ui';

import 'package:chainmetric/models/assets/requirements.dart';
import 'package:chainmetric/models/common/location.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part "asset.g.dart";

@JsonSerializable()
class Asset {
  late final String id;
  late String sku;
  late String name;
  late String type;
  late String info;
  late num cost;
  late int amount;
  String? holder;
  String? state;
  late Location location;
  List<String> tags = <String>[];

  Asset();
  Asset.empty({
    this.id="",
    this.sku="TST001",
    this.name="Test",
    this.type="tech",
    this.info="test",
    this.cost = 1.0,
    this.amount=1,
    this.state=""
  });

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
  Map<String, dynamic> toJson() => _$AssetToJson(this);
}

@JsonSerializable()
class AssetPresenter extends Asset {
  Requirements? requirements;
  Requirements getRequirements() {
    return requirements ?? Requirements.forAsset(assetID: id);
  }

  AssetPresenter();

  factory AssetPresenter.fromJson(Map<String, dynamic> json) =>
      _$AssetPresenterFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AssetPresenterToJson(this);
}

@JsonSerializable()
class AssetsQuery {
  String? type;
  String? holder;
  String? state;
  String? location;
  String? tag;
  int? limit;
  @JsonKey(name: "scroll_id")
  String? scrollID;

  AssetsQuery({
    this.limit,
    this.scrollID,
  });

  factory AssetsQuery.fromJson(Map<String, dynamic> json) =>
      _$AssetsQueryFromJson(json);
  Map<String, dynamic> toJson() => _$AssetsQueryToJson(this);
}

@JsonSerializable()
class AssetsResponse {
  List<AssetPresenter> items = <AssetPresenter>[];
  @JsonKey(name: "scroll_id")
  String? scrollID;

  AssetsResponse();

  factory AssetsResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AssetsResponseToJson(this);
}

@JsonSerializable()
class AssetType {
  late String name;
  String? type;
  @JsonKey(name: "color_hex")
  late String colorHex;
  Color get color => colorFromHex(colorHex);

  AssetType();

  Color colorFromHex(String hexColor) =>
      Color(int.parse("FF${hexColor.length == 6 ? "FF$hexColor" : hexColor}",
          radix: 16));

  factory AssetType.fromJson(Map<String, dynamic> json) =>
      _$AssetTypeFromJson(json);
  Map<String, dynamic> toJson() => _$AssetTypeToJson(this);

  static List<AssetType> listFromJson(List<dynamic> json) =>
      json.map((e) => AssetType.fromJson(e)).toList();
}
