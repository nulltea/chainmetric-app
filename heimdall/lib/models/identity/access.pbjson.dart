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
@$core.Deprecated('Use certificateAuthRequestDescriptor instead')
const CertificateAuthRequest$json = const {
  '1': 'CertificateAuthRequest',
  '2': const [
    const {'1': 'certificate', '3': 2, '4': 1, '5': 12, '8': const {}, '10': 'certificate'},
    const {'1': 'signingKey', '3': 3, '4': 1, '5': 12, '8': const {}, '10': 'signingKey'},
  ],
};

/// Descriptor for `CertificateAuthRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List certificateAuthRequestDescriptor = $convert.base64Decode('ChZDZXJ0aWZpY2F0ZUF1dGhSZXF1ZXN0EikKC2NlcnRpZmljYXRlGAIgASgMQgf6QgR6AhBkUgtjZXJ0aWZpY2F0ZRInCgpzaWduaW5nS2V5GAMgASgMQgf6QgR6AhAZUgpzaWduaW5nS2V5');
@$core.Deprecated('Use certificateAuthResponseDescriptor instead')
const CertificateAuthResponse$json = const {
  '1': 'CertificateAuthResponse',
  '2': const [
    const {'1': 'apiAccessToken', '3': 1, '4': 1, '5': 9, '10': 'apiAccessToken'},
    const {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.chainmetric.identity.presenter.User', '10': 'user'},
  ],
};

/// Descriptor for `CertificateAuthResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List certificateAuthResponseDescriptor = $convert.base64Decode('ChdDZXJ0aWZpY2F0ZUF1dGhSZXNwb25zZRImCg5hcGlBY2Nlc3NUb2tlbhgBIAEoCVIOYXBpQWNjZXNzVG9rZW4SOAoEdXNlchgCIAEoCzIkLmNoYWlubWV0cmljLmlkZW50aXR5LnByZXNlbnRlci5Vc2VyUgR1c2Vy');
