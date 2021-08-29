///
//  Generated code. Do not modify.
//  source: enrollment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use registrationRequestDescriptor instead')
const RegistrationRequest$json = const {
  '1': 'RegistrationRequest',
  '2': const [
    const {'1': 'firstname', '3': 1, '4': 1, '5': 9, '10': 'firstname'},
    const {'1': 'lastname', '3': 2, '4': 1, '5': 9, '10': 'lastname'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '8': const {}, '10': 'email'},
  ],
};

/// Descriptor for `RegistrationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registrationRequestDescriptor = $convert.base64Decode('ChNSZWdpc3RyYXRpb25SZXF1ZXN0EhwKCWZpcnN0bmFtZRgBIAEoCVIJZmlyc3RuYW1lEhoKCGxhc3RuYW1lGAIgASgJUghsYXN0bmFtZRIdCgVlbWFpbBgDIAEoCUIH+kIEcgJgAVIFZW1haWw=');
@$core.Deprecated('Use enrollmentRequestDescriptor instead')
const EnrollmentRequest$json = const {
  '1': 'EnrollmentRequest',
  '2': const [
    const {'1': 'userID', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'userID'},
    const {'1': 'role', '3': 2, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'expireAt', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '8': const {}, '10': 'expireAt'},
  ],
};

/// Descriptor for `EnrollmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enrollmentRequestDescriptor = $convert.base64Decode('ChFFbnJvbGxtZW50UmVxdWVzdBIgCgZ1c2VySUQYASABKAlCCPpCBXIDsAEBUgZ1c2VySUQSEgoEcm9sZRgCIAEoCVIEcm9sZRJACghleHBpcmVBdBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBCCPpCBbIBAggAUghleHBpcmVBdA==');
@$core.Deprecated('Use registrationResponseDescriptor instead')
const RegistrationResponse$json = const {
  '1': 'RegistrationResponse',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.chainmetric.identity.presenter.User', '10': 'user'},
    const {'1': 'accessToken', '3': 2, '4': 1, '5': 9, '10': 'accessToken'},
  ],
};

/// Descriptor for `RegistrationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registrationResponseDescriptor = $convert.base64Decode('ChRSZWdpc3RyYXRpb25SZXNwb25zZRI4CgR1c2VyGAEgASgLMiQuY2hhaW5tZXRyaWMuaWRlbnRpdHkucHJlc2VudGVyLlVzZXJSBHVzZXISIAoLYWNjZXNzVG9rZW4YAiABKAlSC2FjY2Vzc1Rva2Vu');
@$core.Deprecated('Use enrollmentResponseDescriptor instead')
const EnrollmentResponse$json = const {
  '1': 'EnrollmentResponse',
  '2': const [
    const {'1': 'initialPassword', '3': 1, '4': 1, '5': 9, '10': 'initialPassword'},
  ],
};

/// Descriptor for `EnrollmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enrollmentResponseDescriptor = $convert.base64Decode('ChJFbnJvbGxtZW50UmVzcG9uc2USKAoPaW5pdGlhbFBhc3N3b3JkGAEgASgJUg9pbml0aWFsUGFzc3dvcmQ=');
