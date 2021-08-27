// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Asset _$AssetFromJson(Map<String, dynamic> json) {
  return Asset()
    ..id = json['id'] as String
    ..sku = json['sku'] as String
    ..name = json['name'] as String
    ..type = json['type'] as String
    ..info = json['info'] as String
    ..cost = json['cost'] as num
    ..amount = json['amount'] as int
    ..holder = json['holder'] as String?
    ..state = json['state'] as String?
    ..location = Location.fromJson(json['location'] as Map<String, dynamic>)
    ..tags = (json['tags'] as List<dynamic>).map((e) => e as String).toList();
}

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'type': instance.type,
      'info': instance.info,
      'cost': instance.cost,
      'amount': instance.amount,
      'holder': instance.holder,
      'state': instance.state,
      'location': instance.location.toJson(),
      'tags': instance.tags,
    };

AssetPresenter _$AssetPresenterFromJson(Map<String, dynamic> json) {
  return AssetPresenter()
    ..id = json['id'] as String
    ..sku = json['sku'] as String
    ..name = json['name'] as String
    ..type = json['type'] as String
    ..info = json['info'] as String
    ..cost = json['cost'] as num
    ..amount = json['amount'] as int
    ..holder = json['holder'] as String?
    ..state = json['state'] as String?
    ..location = Location.fromJson(json['location'] as Map<String, dynamic>)
    ..tags = (json['tags'] as List<dynamic>).map((e) => e as String).toList()
    ..requirements = json['requirements'] == null
        ? null
        : Requirements.fromJson(json['requirements'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AssetPresenterToJson(AssetPresenter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'type': instance.type,
      'info': instance.info,
      'cost': instance.cost,
      'amount': instance.amount,
      'holder': instance.holder,
      'state': instance.state,
      'location': instance.location.toJson(),
      'tags': instance.tags,
      'requirements': instance.requirements?.toJson(),
    };

AssetsQuery _$AssetsQueryFromJson(Map<String, dynamic> json) {
  return AssetsQuery(
    limit: json['limit'] as int?,
    scrollID: json['scroll_id'] as String?,
  )
    ..type = json['type'] as String?
    ..holder = json['holder'] as String?
    ..state = json['state'] as String?
    ..location = json['location'] as String?
    ..tag = json['tag'] as String?;
}

Map<String, dynamic> _$AssetsQueryToJson(AssetsQuery instance) =>
    <String, dynamic>{
      'type': instance.type,
      'holder': instance.holder,
      'state': instance.state,
      'location': instance.location,
      'tag': instance.tag,
      'limit': instance.limit,
      'scroll_id': instance.scrollID,
    };

AssetsResponse _$AssetsResponseFromJson(Map<String, dynamic> json) {
  return AssetsResponse()
    ..items = (json['items'] as List<dynamic>)
        .map((e) => AssetPresenter.fromJson(e as Map<String, dynamic>))
        .toList()
    ..scrollID = json['scroll_id'] as String?;
}

Map<String, dynamic> _$AssetsResponseToJson(AssetsResponse instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'scroll_id': instance.scrollID,
    };

AssetType _$AssetTypeFromJson(Map<String, dynamic> json) {
  return AssetType()
    ..name = json['name'] as String
    ..type = json['type'] as String?
    ..colorHex = json['color_hex'] as String;
}

Map<String, dynamic> _$AssetTypeToJson(AssetType instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'color_hex': instance.colorHex,
    };
