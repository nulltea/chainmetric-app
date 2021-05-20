import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class Location {
  double latitude;
  double longitude;
  String name;
}
