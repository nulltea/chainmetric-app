import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;

class CertificatesResolver {
  final String organization;

  CertificatesResolver(this.organization);

  Future<String> resolve(String key) =>
      rootBundle.loadString("assets/certs/$key.pem");

  Future<List<int>> resolveBytes(String key) async {
    final data = await rootBundle.load("assets/certs/$key.pem");
    final certBytes = data.buffer.asUint8List();
    return certBytes;
  }
}
