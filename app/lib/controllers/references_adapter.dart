import 'package:flutter/services.dart' show rootBundle;
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:chainmetric/model/asset_model.dart';
import 'package:chainmetric/model/device_model.dart';
import 'package:chainmetric/model/metric_model.dart';
import 'package:chainmetric/model/organization_model.dart';
import 'package:chainmetric/model/requirements_model.dart';

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

    assetTypesMap = Map.fromIterable(assetTypes, key: (at) => at.type, value: (at) => at);
    metricsMap = Map.fromIterable(metrics, key: (m) => m.metric, value: (m) => m);
    organizationsMap = Map.fromIterable(organizations, key: (m) => m.mspID, value: (m) => m);
  }
}
