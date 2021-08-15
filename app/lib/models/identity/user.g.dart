// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as String
    ..firstname = json['firstname'] as String
    ..lastname = json['lastname'] as String
    ..email = json['email'] as String
    ..role = json['role'] as String?
    ..createdAt = DateTime.parse(json['created_at'] as String)
    ..confirmed = json['confirmed'] as bool
    ..expireAt = json['expire_at'] == null
        ? null
        : DateTime.parse(json['expire_at'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'role': instance.role,
      'created_at': instance.createdAt.toIso8601String(),
      'confirmed': instance.confirmed,
      'expire_at': instance.expireAt?.toIso8601String(),
    };
