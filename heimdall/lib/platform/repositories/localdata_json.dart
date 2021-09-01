import 'dart:convert';

import 'package:chainmetric/models/assets/asset.dart';
import 'package:chainmetric/models/assets/requirements.dart';
import 'package:chainmetric/models/device/device.dart';
import 'package:chainmetric/models/identity/organization.dart';
import 'package:chainmetric/models/readings/metric.dart';
import 'package:flutter/services.dart' show rootBundle;

class LocalDataRepo {
  static List<Organization>? organizations = <Organization>[];
  static List<AssetType>? assetTypes = <AssetType>[];
  static List<DeviceProfile>? deviceProfiles = <DeviceProfile>[];
  static List<Metric>? metrics = <Metric>[];
  static Map<String, Requirement>? defaultRequirements;
  static List<String>? userRoles;

  static late Map<String?, AssetType> assetTypesMap;
  static late Map<String?, Metric> metricsMap;
  static late Map<String?, Organization> organizationsMap;

  static Future init() async {
    organizations = Organization.listFromJson(json
        .decode(await rootBundle.loadString("assets/data/organizations.json")));

    assetTypes = AssetType.listFromJson(json
        .decode(await rootBundle.loadString("assets/data/asset_types.json")));

    deviceProfiles = DeviceProfile.listFromJson(json.decode(
        await rootBundle.loadString("assets/data/device_profiles.json")));

    metrics = Metric.listFromJson(
        json.decode(await rootBundle.loadString("assets/data/metrics.json")));

    defaultRequirements = Requirement.mapFromJson(json.decode(
        await rootBundle.loadString("assets/data/default_requirements.json")));

    userRoles = List<String>.from(json
        .decode(await rootBundle.loadString("assets/data/user_roles.json")));

    assetTypesMap = {for (var at in assetTypes!) at.type: at};
    metricsMap = {for (var m in metrics!) m.metric: m};
    organizationsMap = {for (var m in organizations!) m.mspID: m};
  }
}
