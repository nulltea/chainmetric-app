import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class Location {
  num? latitude;
  num? longitude;
  String? name;
}
