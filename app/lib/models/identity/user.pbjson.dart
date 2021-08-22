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
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'firstname', '3': 2, '4': 1, '5': 9, '10': 'firstname'},
    const {'1': 'lastname', '3': 3, '4': 1, '5': 9, '10': 'lastname'},
    const {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'role', '3': 5, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'createdAt', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'confirmed', '3': 7, '4': 1, '5': 8, '10': 'confirmed'},
    const {'1': 'expireAt', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expireAt'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGAEgASgJUgJpZBIcCglmaXJzdG5hbWUYAiABKAlSCWZpcnN0bmFtZRIaCghsYXN0bmFtZRgDIAEoCVIIbGFzdG5hbWUSFAoFZW1haWwYBCABKAlSBWVtYWlsEhIKBHJvbGUYBSABKAlSBHJvbGUSOAoJY3JlYXRlZEF0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EhwKCWNvbmZpcm1lZBgHIAEoCFIJY29uZmlybWVkEjYKCGV4cGlyZUF0GAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIZXhwaXJlQXQ=');
