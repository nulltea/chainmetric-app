import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class Organization {
  String name;
  String mspID;

  Organization({this.name, this.mspID});
}