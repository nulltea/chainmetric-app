///
//  Generated code. Do not modify.
//  source: admin.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use enrollUserRequestDescriptor instead')
const EnrollUserRequest$json = const {
  '1': 'EnrollUserRequest',
  '2': const [
    const {'1': 'userID', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'userID'},
    const {'1': 'role', '3': 2, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'expireAt', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '8': const {}, '10': 'expireAt'},
  ],
};

/// Descriptor for `EnrollUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enrollUserRequestDescriptor = $convert.base64Decode('ChFFbnJvbGxVc2VyUmVxdWVzdBIgCgZ1c2VySUQYASABKAlCCPpCBXIDsAEBUgZ1c2VySUQSEgoEcm9sZRgCIAEoCVIEcm9sZRJACghleHBpcmVBdBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBCCPpCBbIBAggAUghleHBpcmVBdA==');
@$core.Deprecated('Use enrollUserResponseDescriptor instead')
const EnrollUserResponse$json = const {
  '1': 'EnrollUserResponse',
  '2': const [
    const {'1': 'initialPassword', '3': 1, '4': 1, '5': 9, '10': 'initialPassword'},
  ],
};

/// Descriptor for `EnrollUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enrollUserResponseDescriptor = $convert.base64Decode('ChJFbnJvbGxVc2VyUmVzcG9uc2USKAoPaW5pdGlhbFBhc3N3b3JkGAEgASgJUg9pbml0aWFsUGFzc3dvcmQ=');
