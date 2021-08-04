import 'package:flutter/services.dart' show rootBundle;
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:chainmetric/models/asset_model.dart';
import 'package:chainmetric/models/device_model.dart';
import 'package:chainmetric/models/metric_model.dart';
import 'package:chainmetric/models/organization_model.dart';
import 'package:chainmetric/models/requirements_model.dart';

class References {
  static List<Organization> organizations = <Organization>[];
  static List<AssetType> assetTypes = <AssetType>[];
  static List<DeviceProfile> deviceProfiles = <DeviceProfile>[];
  static List<Metric> metrics = <Metric>[];
  static Map<String, Requirement> defaultRequirements;

  static Map<String,AssetType> assetTypesMap;
  static Map<String,Metric> metricsMap;
  static Map<String,Organization> organizationsMap;

  static Future init() async {
    organizations = JsonMapper.deserialize<List<Organization>>(
        await rootBundle.loadString("assets/data/organizations.json")
    );
    assetTypes = JsonMapper.deserialize<List<AssetType>>(
        await rootBundle.loadString("assets/data/asset_types.json")
    );
    deviceProfiles = JsonMapper.deserialize<List<DeviceProfile>>(
        await rootBundle.loadString("assets/data/device_profiles.json")
    );
    metrics = JsonMapper.deserialize<List<Metric>>(
        await rootBundle.loadString("assets/data/metrics.json")
    );
    defaultRequirements = JsonMapper.deserialize<Map<String, Requirement>>(
        await rootBundle.loadString("assets/data/default_requirements.json")
    );

    assetTypesMap = { for (var at in assetTypes) at.type : at };
    metricsMap = { for (var m in metrics) m.metric : m };
    organizationsMap = { for (var m in organizations) m.mspID : m };
  }
}
