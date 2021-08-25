import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class CerificatesResolver {
  final String organization;

  CerificatesResolver(this.organization);

  Future<String> resolve(String key) =>
      rootBundle.loadString("assets/certs/$key.pem");

  Future<List<int>> resolveBytes(String key) async {
    return utf8.encode(await resolve(key));
  }
}
