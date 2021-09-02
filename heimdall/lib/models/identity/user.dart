import 'package:json_annotation/json_annotation.dart';
import 'package:chainmetric/models/identity/user.pb.dart' as proto;

part "user.g.dart";

@JsonSerializable()
class AppUser {
  late final String id;
  late final String firstname;
  late final String lastname;
  late final String username;
  late final String email;
  late final String role;
  late final String organization;
  late final DateTime createdAt;
  @JsonKey(defaultValue: false)
  late final bool confirmed;
  bool? trained;
  String? accessToken;

  AppUser();

  String get displayName => username.split("@")[0];

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  factory AppUser.fromProto(proto.User user, String organization, {String? accessToken}) {
    final json = user.toProto3Json() as Map<String, dynamic>?;
    if (json == null) throw NullThrownError();
    json["organization"] = organization;
    return AppUser.fromJson(json)
        ..accessToken = accessToken;
  }
}