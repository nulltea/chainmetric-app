import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:yaml/yaml.dart';

class FabricConnection {
  final String _organization;
  final String _configPath;
  late final String _configStr;
  late final Map<String, dynamic>? _config;
  late final Directory _appDir;

  FabricConnection(this._configPath, this._organization);

  Future<FabricConnection> init() async {
    _configStr = await rootBundle.loadString(_configPath);
    final yaml = loadYaml(_configStr)
    as YamlMap;

    _config = {for (var key in yaml.keys) key as String: yaml[key]};
    _appDir = await getApplicationDocumentsDirectory();

    return this;
  }

  dynamic getConfigValue(String compositeKey) {
    dynamic value = _config;
    for (final key in compositeKey.split(".")) {
      value = value[key];
    }
    return value;
  }

  @override
  String toString() {
    return _configStr
        .replaceAll("{keystore-path}", _appDir.path)
        .replaceAll("{organization}", _organization);
  }
}