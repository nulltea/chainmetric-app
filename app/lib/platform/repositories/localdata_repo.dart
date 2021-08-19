import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:chainmetric/models/assets/asset.dart';
import 'package:chainmetric/models/device/device.dart';
import 'package:chainmetric/models/readings/metric.dart';
import 'package:chainmetric/models/identity/organization.dart';
import 'package:chainmetric/models/assets/requirements.dart';

class LocalData {
  static List<Organization>? organizations = <Organization>[];
  static List<AssetType>? assetTypes = <AssetType>[];
  static List<DeviceProfile>? deviceProfiles = <DeviceProfile>[];
  static List<Metric>? metrics = <Metric>[];
  static Map<String, Requirement>? defaultRequirements;

  static late Map<String?,AssetType> assetTypesMap;
  static late Map<String?,Metric> metricsMap;
  static late Map<String?,Organization> organizationsMap;

  static Future init() async {
    organizations = json.decode(
        await rootBundle.loadString("assets/data/organizations.json")
    ).map((json) => Organization.fromJson(json)).toList();

    assetTypes = json.decode(
        await rootBundle.loadString("assets/data/asset_types.json")
    ).map((json) => AssetType.fromJson(json)).toList();

    deviceProfiles = json.decode(
        await rootBundle.loadString("assets/data/device_profiles.json")
    ).map((json) => DeviceProfile.fromJson(json)).toList();

    metrics = json.decode(
        await rootBundle.loadString("assets/data/metrics.json")
    ).map((json) => Metric.fromJson(json)).toList();

    defaultRequirements = Map<String, Map<String, dynamic>>.from(json.decode(
        await rootBundle.loadString("assets/data/default_requirements.json")
    )).map((key, value) => MapEntry(key, Requirement.fromJson(value)));

    assetTypesMap = { for (var at in assetTypes!) at.type : at };
    metricsMap = { for (var m in metrics!) m.metric : m };
    organizationsMap = { for (var m in organizations!) m.mspID : m };
  }
}
