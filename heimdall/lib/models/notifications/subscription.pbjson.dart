///
//  Generated code. Do not modify.
//  source: subscription.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use subscriptionRequestDescriptor instead')
const SubscriptionRequest$json = const {
  '1': 'SubscriptionRequest',
  '2': const [
    const {'1': 'requirementsViolation', '3': 1, '4': 1, '5': 11, '6': '.chainmetric.notifications.SubscriptionRequest.RequirementsViolationEventArgs', '9': 0, '10': 'requirementsViolation'},
    const {'1': 'noop', '3': 2, '4': 1, '5': 11, '6': '.chainmetric.notifications.SubscriptionRequest.NoopEventArgs', '9': 0, '10': 'noop'},
    const {'1': 'expireAt', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '8': const {}, '10': 'expireAt'},
  ],
  '3': const [SubscriptionRequest_RequirementsViolationEventArgs$json, SubscriptionRequest_NoopEventArgs$json],
  '8': const [
    const {'1': 'args'},
  ],
};

@$core.Deprecated('Use subscriptionRequestDescriptor instead')
const SubscriptionRequest_RequirementsViolationEventArgs$json = const {
  '1': 'RequirementsViolationEventArgs',
  '2': const [
    const {'1': 'assetID', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'assetID'},
    const {'1': 'metrics', '3': 2, '4': 3, '5': 9, '10': 'metrics'},
  ],
};

@$core.Deprecated('Use subscriptionRequestDescriptor instead')
const SubscriptionRequest_NoopEventArgs$json = const {
  '1': 'NoopEventArgs',
};

/// Descriptor for `SubscriptionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscriptionRequestDescriptor = $convert.base64Decode('ChNTdWJzY3JpcHRpb25SZXF1ZXN0EoUBChVyZXF1aXJlbWVudHNWaW9sYXRpb24YASABKAsyTS5jaGFpbm1ldHJpYy5ub3RpZmljYXRpb25zLlN1YnNjcmlwdGlvblJlcXVlc3QuUmVxdWlyZW1lbnRzVmlvbGF0aW9uRXZlbnRBcmdzSABSFXJlcXVpcmVtZW50c1Zpb2xhdGlvbhJSCgRub29wGAIgASgLMjwuY2hhaW5tZXRyaWMubm90aWZpY2F0aW9ucy5TdWJzY3JpcHRpb25SZXF1ZXN0Lk5vb3BFdmVudEFyZ3NIAFIEbm9vcBJACghleHBpcmVBdBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBCCPpCBbIBAggAUghleHBpcmVBdBpdCh5SZXF1aXJlbWVudHNWaW9sYXRpb25FdmVudEFyZ3MSIQoHYXNzZXRJRBgBIAEoCUIH+kIEcgIQBVIHYXNzZXRJRBIYCgdtZXRyaWNzGAIgAygJUgdtZXRyaWNzGg8KDU5vb3BFdmVudEFyZ3NCBgoEYXJncw==');
@$core.Deprecated('Use subscriptionResponseDescriptor instead')
const SubscriptionResponse$json = const {
  '1': 'SubscriptionResponse',
  '2': const [
    const {'1': 'topics', '3': 1, '4': 3, '5': 9, '10': 'topics'},
  ],
};

/// Descriptor for `SubscriptionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscriptionResponseDescriptor = $convert.base64Decode('ChRTdWJzY3JpcHRpb25SZXNwb25zZRIWCgZ0b3BpY3MYASADKAlSBnRvcGljcw==');
@$core.Deprecated('Use cancellationRequestDescriptor instead')
const CancellationRequest$json = const {
  '1': 'CancellationRequest',
  '2': const [
    const {'1': 'topics', '3': 1, '4': 3, '5': 9, '10': 'topics'},
  ],
};

/// Descriptor for `CancellationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancellationRequestDescriptor = $convert.base64Decode('ChNDYW5jZWxsYXRpb25SZXF1ZXN0EhYKBnRvcGljcxgBIAMoCVIGdG9waWNz');
