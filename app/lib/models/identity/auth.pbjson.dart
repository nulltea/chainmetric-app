///
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use authRequestDescriptor instead')
const AuthRequest$json = const {
  '1': 'AuthRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'email'},
    const {'1': 'passwordHash', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'passwordHash'},
  ],
};

/// Descriptor for `AuthRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authRequestDescriptor = $convert.base64Decode('CgtBdXRoUmVxdWVzdBIdCgVlbWFpbBgBIAEoCUIH+kIEcgJgAVIFZW1haWwSKwoMcGFzc3dvcmRIYXNoGAIgASgJQgf6QgRyAiAIUgxwYXNzd29yZEhhc2g=');
@$core.Deprecated('Use setPasswordRequestDescriptor instead')
const SetPasswordRequest$json = const {
  '1': 'SetPasswordRequest',
  '2': const [
    const {'1': 'passwordHash', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'passwordHash'},
  ],
};

/// Descriptor for `SetPasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPasswordRequestDescriptor = $convert.base64Decode('ChJTZXRQYXNzd29yZFJlcXVlc3QSKwoMcGFzc3dvcmRIYXNoGAIgASgJQgf6QgRyAiAIUgxwYXNzd29yZEhhc2g=');
@$core.Deprecated('Use authResponseDescriptor instead')
const AuthResponse$json = const {
  '1': 'AuthResponse',
  '2': const [
    const {'1': 'secretToken', '3': 1, '4': 1, '5': 9, '10': 'secretToken'},
    const {'1': 'accessToken', '3': 2, '4': 1, '5': 9, '10': 'accessToken'},
  ],
};

/// Descriptor for `AuthResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authResponseDescriptor = $convert.base64Decode('CgxBdXRoUmVzcG9uc2USIAoLc2VjcmV0VG9rZW4YASABKAlSC3NlY3JldFRva2VuEiAKC2FjY2Vzc1Rva2VuGAIgASgJUgthY2Nlc3NUb2tlbg==');
