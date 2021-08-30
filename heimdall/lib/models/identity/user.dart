import 'package:chainmetric/models/identity/user.pb.dart';

extension UserExtension on User {
  String get username => "${firstname.toLowerCase()}.${lastname.toLowerCase()}";

  String get fullName => "$firstname $lastname";
}