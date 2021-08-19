import 'package:json_annotation/json_annotation.dart';

part "auth.g.dart";

@JsonSerializable()
class AuthCredentials {
  String? organization;
  String? certificate;
  String? privateKey;

  AuthCredentials();

  factory AuthCredentials.fromJson(Map<String, dynamic> json) =>
      _$AuthCredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$AuthCredentialsToJson(this);
}
