import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@JsonSerializable()
class Organization {
  late final String name;
  late final String mspID;

  Organization();

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);
  Map<String, dynamic> toJson() => _$OrganizationToJson(this);

  static List<Organization> listFromJson(List<dynamic> json) =>
      json.map((e) => Organization.fromJson(e)).toList();
}
