// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthCredentials _$AuthCredentialsFromJson(Map<String, dynamic> json) {
  return AuthCredentials()
    ..organization = json['organization'] as String?
    ..certificate = json['certificate'] as String?
    ..privateKey = json['privateKey'] as String?;
}

Map<String, dynamic> _$AuthCredentialsToJson(AuthCredentials instance) =>
    <String, dynamic>{
      'organization': instance.organization,
      'certificate': instance.certificate,
      'privateKey': instance.privateKey,
    };
