import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class AuthCredentials {
  String? organization;
  String? certificate;
  String? privateKey;
}