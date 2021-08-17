import 'package:json_annotation/json_annotation.dart';

part "user.g.dart";

@JsonSerializable()
class User {
  late final String id;
  late final String firstname;
  late final String lastname;
  late final String email;
  late final String? role;
  @JsonKey(name: "created_at")
  late final DateTime createdAt;
  late final bool confirmed;
  @JsonKey(name: "expire_at")
  late final DateTime? expireAt;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}