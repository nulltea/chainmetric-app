// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return Device()
    ..id = json['id'] as String
    ..ip = json['ip'] as String
    ..mac = json['mac'] as String
    ..name = json['name'] as String?
    ..hostname = json['hostname'] as String
    ..profile = json['profile'] as String?
    ..supports =
        (json['supports'] as List<dynamic>).map((e) => e as String).toList()
    ..holder = json['holder'] as String?
    ..state = json['state'] as String?
    ..location = json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'ip': instance.ip,
      'mac': instance.mac,
      'name': instance.name,
      'hostname': instance.hostname,
      'profile': instance.profile,
      'supports': instance.supports,
      'holder': instance.holder,
      'state': instance.state,
      'location': instance.location?.toJson(),
    };

DeviceProfile _$DeviceProfileFromJson(Map<String, dynamic> json) {
  return DeviceProfile()
    ..name = json['name'] as String
    ..profile = json['profile'] as String?
    ..colorHex = json['color_hex'] as String;
}

Map<String, dynamic> _$DeviceProfileToJson(DeviceProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'profile': instance.profile,
      'color_hex': instance.colorHex,
    };

DeviceCommandRequest _$DeviceCommandRequestFromJson(Map<String, dynamic> json) {
  return DeviceCommandRequest(
    json['device_id'] as String,
    _$enumDecode(_$DeviceCommandEnumMap, json['command']),
    args: (json['args'] as List<dynamic>?)?.map((e) => e as Object).toList(),
  );
}

Map<String, dynamic> _$DeviceCommandRequestToJson(
        DeviceCommandRequest instance) =>
    <String, dynamic>{
      'device_id': instance.deviceID,
      'command': _$DeviceCommandEnumMap[instance.command],
      'args': instance.args,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$DeviceCommandEnumMap = {
  DeviceCommand.pause: 'pause',
  DeviceCommand.resume: 'resume',
  DeviceCommand.pairBluetooth: 'pairBluetooth',
};

DeviceCommandLogEntry _$DeviceCommandLogEntryFromJson(
    Map<String, dynamic> json) {
  return DeviceCommandLogEntry()
    ..deviceID = json['device_id'] as String?
    ..command = _$enumDecodeNullable(_$DeviceCommandEnumMap, json['command'])
    ..args = (json['args'] as List<dynamic>?)?.map((e) => e as Object).toList()
    ..status = _$enumDecodeNullable(
        _$DeviceCommandStatusEnumMap, json['status'],
        unknownValue: DeviceCommandStatus.unknown)
    ..error = json['error'] as String?
    ..timestamp = json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String);
}

Map<String, dynamic> _$DeviceCommandLogEntryToJson(
        DeviceCommandLogEntry instance) =>
    <String, dynamic>{
      'device_id': instance.deviceID,
      'command': _$DeviceCommandEnumMap[instance.command],
      'args': instance.args,
      'status': _$DeviceCommandStatusEnumMap[instance.status],
      'error': instance.error,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$DeviceCommandStatusEnumMap = {
  DeviceCommandStatus.completed: 'completed',
  DeviceCommandStatus.processing: 'processing',
  DeviceCommandStatus.failed: 'failed',
  DeviceCommandStatus.unknown: 'unknown',
};

PairedDevice _$PairedDeviceFromJson(Map<String, dynamic> json) {
  return PairedDevice()
    ..hardwareID = json['hardwareID'] as String
    ..deviceID = json['deviceID'] as String
    ..advertisedName = json['advertisedName'] as String;
}

Map<String, dynamic> _$PairedDeviceToJson(PairedDevice instance) =>
    <String, dynamic>{
      'hardwareID': instance.hardwareID,
      'deviceID': instance.deviceID,
      'advertisedName': instance.advertisedName,
    };
