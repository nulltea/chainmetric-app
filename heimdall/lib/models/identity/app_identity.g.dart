// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppIdentity _$AppIdentityFromJson(Map<String, dynamic> json) {
  return AppIdentity(
    json['organization'] as String,
    json['username'] as String,
    accessToken: json['accessToken'] as String?,
  );
}

Map<String, dynamic> _$AppIdentityToJson(AppIdentity instance) =>
    <String, dynamic>{
      'organization': instance.organization,
      'username': instance.username,
      'accessToken': instance.accessToken,
    };
