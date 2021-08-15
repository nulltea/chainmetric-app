import "package:http/http.dart" as http;

class IdentityService {
  final String organization;

  String get apiHost => "https://identity.$organization.org.chainmetric.network";

  IdentityService(this.organization);

}