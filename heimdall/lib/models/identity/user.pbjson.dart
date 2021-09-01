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
    const {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'firstname', '3': 3, '4': 1, '5': 9, '10': 'firstname'},
    const {'1': 'lastname', '3': 4, '4': 1, '5': 9, '10': 'lastname'},
    const {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'role', '3': 6, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'createdAt', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'confirmed', '3': 8, '4': 1, '5': 8, '10': 'confirmed'},
    const {'1': 'trained', '3': 9, '4': 1, '5': 8, '10': 'trained'},
    const {'1': 'expireAt', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expireAt'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGAEgASgJUgJpZBIaCgh1c2VybmFtZRgCIAEoCVIIdXNlcm5hbWUSHAoJZmlyc3RuYW1lGAMgASgJUglmaXJzdG5hbWUSGgoIbGFzdG5hbWUYBCABKAlSCGxhc3RuYW1lEhQKBWVtYWlsGAUgASgJUgVlbWFpbBISCgRyb2xlGAYgASgJUgRyb2xlEjgKCWNyZWF0ZWRBdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBIcCgljb25maXJtZWQYCCABKAhSCWNvbmZpcm1lZBIYCgd0cmFpbmVkGAkgASgIUgd0cmFpbmVkEjYKCGV4cGlyZUF0GAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIZXhwaXJlQXQ=');
@$core.Deprecated('Use usersRequestDescriptor instead')
const UsersRequest$json = const {
  '1': 'UsersRequest',
};

/// Descriptor for `UsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List usersRequestDescriptor = $convert.base64Decode('CgxVc2Vyc1JlcXVlc3Q=');
@$core.Deprecated('Use usersResponseDescriptor instead')
const UsersResponse$json = const {
  '1': 'UsersResponse',
  '2': const [
    const {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.chainmetric.identity.presenter.User', '10': 'users'},
    const {'1': 'count', '3': 2, '4': 1, '5': 3, '10': 'count'},
  ],
};

/// Descriptor for `UsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List usersResponseDescriptor = $convert.base64Decode('Cg1Vc2Vyc1Jlc3BvbnNlEjoKBXVzZXJzGAEgAygLMiQuY2hhaW5tZXRyaWMuaWRlbnRpdHkucHJlc2VudGVyLlVzZXJSBXVzZXJzEhQKBWNvdW50GAIgASgDUgVjb3VudA==');
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
@$core.Deprecated('Use changePasswordRequestDescriptor instead')
const ChangePasswordRequest$json = const {
  '1': 'ChangePasswordRequest',
  '2': const [
    const {'1': 'prevPasscode', '3': 1, '4': 1, '5': 9, '10': 'prevPasscode'},
    const {'1': 'newPasscode', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'newPasscode'},
  ],
};

/// Descriptor for `ChangePasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changePasswordRequestDescriptor = $convert.base64Decode('ChVDaGFuZ2VQYXNzd29yZFJlcXVlc3QSIgoMcHJldlBhc3Njb2RlGAEgASgJUgxwcmV2UGFzc2NvZGUSKQoLbmV3UGFzc2NvZGUYAiABKAlCB/pCBHICIAhSC25ld1Bhc3Njb2Rl');
