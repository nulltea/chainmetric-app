///
//  Generated code. Do not modify.
//  source: access.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use fabricCredentialsRequestDescriptor instead')
const FabricCredentialsRequest$json = const {
  '1': 'FabricCredentialsRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'email'},
    const {'1': 'passcode', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'passcode'},
  ],
};

/// Descriptor for `FabricCredentialsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fabricCredentialsRequestDescriptor = $convert.base64Decode('ChhGYWJyaWNDcmVkZW50aWFsc1JlcXVlc3QSHQoFZW1haWwYASABKAlCB/pCBHICYAFSBWVtYWlsEiMKCHBhc3Njb2RlGAIgASgJQgf6QgRyAiAIUghwYXNzY29kZQ==');
@$core.Deprecated('Use fabricCredentialsResponseDescriptor instead')
const FabricCredentialsResponse$json = const {
  '1': 'FabricCredentialsResponse',
  '2': const [
    const {'1': 'secret', '3': 1, '4': 1, '5': 11, '6': '.chainmetric.identity.presenter.VaultSecret', '10': 'secret'},
    const {'1': 'apiAccessToken', '3': 2, '4': 1, '5': 9, '10': 'apiAccessToken'},
    const {'1': 'user', '3': 3, '4': 1, '5': 11, '6': '.chainmetric.identity.presenter.User', '10': 'user'},
  ],
};

/// Descriptor for `FabricCredentialsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fabricCredentialsResponseDescriptor = $convert.base64Decode('ChlGYWJyaWNDcmVkZW50aWFsc1Jlc3BvbnNlEkMKBnNlY3JldBgBIAEoCzIrLmNoYWlubWV0cmljLmlkZW50aXR5LnByZXNlbnRlci5WYXVsdFNlY3JldFIGc2VjcmV0EiYKDmFwaUFjY2Vzc1Rva2VuGAIgASgJUg5hcGlBY2Nlc3NUb2tlbhI4CgR1c2VyGAMgASgLMiQuY2hhaW5tZXRyaWMuaWRlbnRpdHkucHJlc2VudGVyLlVzZXJSBHVzZXI=');
@$core.Deprecated('Use vaultSecretDescriptor instead')
const VaultSecret$json = const {
  '1': 'VaultSecret',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `VaultSecret`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vaultSecretDescriptor = $convert.base64Decode('CgtWYXVsdFNlY3JldBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SEgoEcGF0aBgCIAEoCVIEcGF0aA==');
@$core.Deprecated('Use updatePasswordRequestDescriptor instead')
const UpdatePasswordRequest$json = const {
  '1': 'UpdatePasswordRequest',
  '2': const [
    const {'1': 'prevPasscode', '3': 1, '4': 1, '5': 9, '10': 'prevPasscode'},
    const {'1': 'newPasscode', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'newPasscode'},
  ],
};

/// Descriptor for `UpdatePasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePasswordRequestDescriptor = $convert.base64Decode('ChVVcGRhdGVQYXNzd29yZFJlcXVlc3QSIgoMcHJldlBhc3Njb2RlGAEgASgJUgxwcmV2UGFzc2NvZGUSKQoLbmV3UGFzc2NvZGUYAiABKAlCB/pCBHICIAhSC25ld1Bhc3Njb2Rl');
