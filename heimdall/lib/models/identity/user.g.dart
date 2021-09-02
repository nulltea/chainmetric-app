// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return AppUser()
    ..id = json['id'] as String
    ..firstname = json['firstname'] as String
    ..lastname = json['lastname'] as String
    ..username = json['username'] as String
    ..email = json['email'] as String
    ..role = json['role'] as String
    ..organization = json['organization'] as String
    ..createdAt = DateTime.parse(json['createdAt'] as String)
    ..confirmed = json['confirmed'] as bool? ?? false
    ..accessToken = json['accessToken'] as String?;
}

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'username': instance.username,
      'email': instance.email,
      'role': instance.role,
      'organization': instance.organization,
      'createdAt': instance.createdAt.toIso8601String(),
      'confirmed': instance.confirmed,
      'accessToken': instance.accessToken,
    };
