import 'package:chainmetric/models/identity/user.pb.dart';
import 'package:json_annotation/json_annotation.dart';

part "app_identity.g.dart";

@JsonSerializable()
class AppIdentity {
  late final String organization;
  late final String username;
  User? user;
  String? accessToken;

  AppIdentity(this.organization, this.username, {this.accessToken, this.user});

  factory AppIdentity.fromJson(Map<String, dynamic> json) =>
      _$AppIdentityFromJson(json);
  Map<String, dynamic> toJson() => _$AppIdentityToJson(this);
}