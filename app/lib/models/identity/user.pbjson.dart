///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'id', '3': 7, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'firstname', '3': 6, '4': 1, '5': 9, '10': 'firstname'},
    const {'1': 'lastname', '3': 8, '4': 1, '5': 9, '10': 'lastname'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'role', '3': 9, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'createdAt', '3': 2, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'confirmed', '3': 1, '4': 1, '5': 8, '10': 'confirmed'},
    const {'1': 'expireAt', '3': 5, '4': 1, '5': 9, '10': 'expireAt'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGAcgASgJUgJpZBIcCglmaXJzdG5hbWUYBiABKAlSCWZpcnN0bmFtZRIaCghsYXN0bmFtZRgIIAEoCVIIbGFzdG5hbWUSFAoFZW1haWwYAyABKAlSBWVtYWlsEhIKBHJvbGUYCSABKAlSBHJvbGUSHAoJY3JlYXRlZEF0GAIgASgJUgljcmVhdGVkQXQSHAoJY29uZmlybWVkGAEgASgIUgljb25maXJtZWQSGgoIZXhwaXJlQXQYBSABKAlSCGV4cGlyZUF0');
@$core.Deprecated('Use registrationRequestDescriptor instead')
const RegistrationRequest$json = const {
  '1': 'RegistrationRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'firstname', '3': 2, '4': 1, '5': 9, '10': 'firstname'},
    const {'1': 'lastname', '3': 3, '4': 1, '5': 9, '10': 'lastname'},
  ],
};

/// Descriptor for `RegistrationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registrationRequestDescriptor = $convert.base64Decode('ChNSZWdpc3RyYXRpb25SZXF1ZXN0EhQKBWVtYWlsGAEgASgJUgVlbWFpbBIcCglmaXJzdG5hbWUYAiABKAlSCWZpcnN0bmFtZRIaCghsYXN0bmFtZRgDIAEoCVIIbGFzdG5hbWU=');
@$core.Deprecated('Use enrollmentRequestDescriptor instead')
const EnrollmentRequest$json = const {
  '1': 'EnrollmentRequest',
  '2': const [
    const {'1': 'userID', '3': 1, '4': 1, '5': 9, '10': 'userID'},
    const {'1': 'role', '3': 2, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'expireAt', '3': 3, '4': 1, '5': 9, '10': 'expireAt'},
  ],
};

/// Descriptor for `EnrollmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enrollmentRequestDescriptor = $convert.base64Decode('ChFFbnJvbGxtZW50UmVxdWVzdBIWCgZ1c2VySUQYASABKAlSBnVzZXJJRBISCgRyb2xlGAIgASgJUgRyb2xlEhoKCGV4cGlyZUF0GAMgASgJUghleHBpcmVBdA==');
