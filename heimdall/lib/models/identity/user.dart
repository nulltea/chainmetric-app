import 'package:chainmetric/models/identity/user.pb.dart';

extension UserExtension on User {
  String get username => "${firstname.toLowerCase()}.${lastname.toLowerCase()}@chipa-inu.org.chainmetric.network";

  String get fullName => "$firstname $lastname";
}