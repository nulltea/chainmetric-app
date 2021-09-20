///
//  Generated code. Do not modify.
//  source: subscription.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'package:chainmetric/models/generated/google/protobuf/timestamp.pb.dart' as $0;

class SubscriptionRequest_RequirementsViolationEventArgs extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscriptionRequest.RequirementsViolationEventArgs', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.notifications'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'assetID', protoName: 'assetID')
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metrics')
    ..hasRequiredFields = false
  ;

  SubscriptionRequest_RequirementsViolationEventArgs._() : super();
  factory SubscriptionRequest_RequirementsViolationEventArgs({
    $core.String? assetID,
    $core.Iterable<$core.String>? metrics,
  }) {
    final _result = create();
    if (assetID != null) {
      _result.assetID = assetID;
    }
    if (metrics != null) {
      _result.metrics.addAll(metrics);
    }
    return _result;
  }
  factory SubscriptionRequest_RequirementsViolationEventArgs.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscriptionRequest_RequirementsViolationEventArgs.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscriptionRequest_RequirementsViolationEventArgs clone() => SubscriptionRequest_RequirementsViolationEventArgs()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscriptionRequest_RequirementsViolationEventArgs copyWith(void Function(SubscriptionRequest_RequirementsViolationEventArgs) updates) => super.copyWith((message) => updates(message as SubscriptionRequest_RequirementsViolationEventArgs)) as SubscriptionRequest_RequirementsViolationEventArgs; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscriptionRequest_RequirementsViolationEventArgs create() => SubscriptionRequest_RequirementsViolationEventArgs._();
  SubscriptionRequest_RequirementsViolationEventArgs createEmptyInstance() => create();
  static $pb.PbList<SubscriptionRequest_RequirementsViolationEventArgs> createRepeated() => $pb.PbList<SubscriptionRequest_RequirementsViolationEventArgs>();
  @$core.pragma('dart2js:noInline')
  static SubscriptionRequest_RequirementsViolationEventArgs getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscriptionRequest_RequirementsViolationEventArgs>(create);
  static SubscriptionRequest_RequirementsViolationEventArgs? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetID => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAssetID() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetID() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get metrics => $_getList(1);
}

class SubscriptionRequest_NoopEventArgs extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscriptionRequest.NoopEventArgs', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.notifications'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SubscriptionRequest_NoopEventArgs._() : super();
  factory SubscriptionRequest_NoopEventArgs() => create();
  factory SubscriptionRequest_NoopEventArgs.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscriptionRequest_NoopEventArgs.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscriptionRequest_NoopEventArgs clone() => SubscriptionRequest_NoopEventArgs()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscriptionRequest_NoopEventArgs copyWith(void Function(SubscriptionRequest_NoopEventArgs) updates) => super.copyWith((message) => updates(message as SubscriptionRequest_NoopEventArgs)) as SubscriptionRequest_NoopEventArgs; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscriptionRequest_NoopEventArgs create() => SubscriptionRequest_NoopEventArgs._();
  SubscriptionRequest_NoopEventArgs createEmptyInstance() => create();
  static $pb.PbList<SubscriptionRequest_NoopEventArgs> createRepeated() => $pb.PbList<SubscriptionRequest_NoopEventArgs>();
  @$core.pragma('dart2js:noInline')
  static SubscriptionRequest_NoopEventArgs getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscriptionRequest_NoopEventArgs>(create);
  static SubscriptionRequest_NoopEventArgs? _defaultInstance;
}

enum SubscriptionRequest_Args {
  requirementsViolation, 
  noop, 
  notSet
}

class SubscriptionRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, SubscriptionRequest_Args> _SubscriptionRequest_ArgsByTag = {
    1 : SubscriptionRequest_Args.requirementsViolation,
    2 : SubscriptionRequest_Args.noop,
    0 : SubscriptionRequest_Args.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscriptionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.notifications'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<SubscriptionRequest_RequirementsViolationEventArgs>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requirementsViolation', protoName: 'requirementsViolation', subBuilder: SubscriptionRequest_RequirementsViolationEventArgs.create)
    ..aOM<SubscriptionRequest_NoopEventArgs>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'noop', subBuilder: SubscriptionRequest_NoopEventArgs.create)
    ..aOM<$0.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expireAt', protoName: 'expireAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  SubscriptionRequest._() : super();
  factory SubscriptionRequest({
    SubscriptionRequest_RequirementsViolationEventArgs? requirementsViolation,
    SubscriptionRequest_NoopEventArgs? noop,
    $0.Timestamp? expireAt,
  }) {
    final _result = create();
    if (requirementsViolation != null) {
      _result.requirementsViolation = requirementsViolation;
    }
    if (noop != null) {
      _result.noop = noop;
    }
    if (expireAt != null) {
      _result.expireAt = expireAt;
    }
    return _result;
  }
  factory SubscriptionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscriptionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscriptionRequest clone() => SubscriptionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscriptionRequest copyWith(void Function(SubscriptionRequest) updates) => super.copyWith((message) => updates(message as SubscriptionRequest)) as SubscriptionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscriptionRequest create() => SubscriptionRequest._();
  SubscriptionRequest createEmptyInstance() => create();
  static $pb.PbList<SubscriptionRequest> createRepeated() => $pb.PbList<SubscriptionRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscriptionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscriptionRequest>(create);
  static SubscriptionRequest? _defaultInstance;

  SubscriptionRequest_Args whichArgs() => _SubscriptionRequest_ArgsByTag[$_whichOneof(0)]!;
  void clearArgs() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  SubscriptionRequest_RequirementsViolationEventArgs get requirementsViolation => $_getN(0);
  @$pb.TagNumber(1)
  set requirementsViolation(SubscriptionRequest_RequirementsViolationEventArgs v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequirementsViolation() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequirementsViolation() => clearField(1);
  @$pb.TagNumber(1)
  SubscriptionRequest_RequirementsViolationEventArgs ensureRequirementsViolation() => $_ensure(0);

  @$pb.TagNumber(2)
  SubscriptionRequest_NoopEventArgs get noop => $_getN(1);
  @$pb.TagNumber(2)
  set noop(SubscriptionRequest_NoopEventArgs v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNoop() => $_has(1);
  @$pb.TagNumber(2)
  void clearNoop() => clearField(2);
  @$pb.TagNumber(2)
  SubscriptionRequest_NoopEventArgs ensureNoop() => $_ensure(1);

  @$pb.TagNumber(3)
  $0.Timestamp get expireAt => $_getN(2);
  @$pb.TagNumber(3)
  set expireAt($0.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpireAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpireAt() => clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureExpireAt() => $_ensure(2);
}

class SubscriptionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscriptionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.notifications'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topics')
    ..hasRequiredFields = false
  ;

  SubscriptionResponse._() : super();
  factory SubscriptionResponse({
    $core.Iterable<$core.String>? topics,
  }) {
    final _result = create();
    if (topics != null) {
      _result.topics.addAll(topics);
    }
    return _result;
  }
  factory SubscriptionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscriptionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscriptionResponse clone() => SubscriptionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscriptionResponse copyWith(void Function(SubscriptionResponse) updates) => super.copyWith((message) => updates(message as SubscriptionResponse)) as SubscriptionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscriptionResponse create() => SubscriptionResponse._();
  SubscriptionResponse createEmptyInstance() => create();
  static $pb.PbList<SubscriptionResponse> createRepeated() => $pb.PbList<SubscriptionResponse>();
  @$core.pragma('dart2js:noInline')
  static SubscriptionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscriptionResponse>(create);
  static SubscriptionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get topics => $_getList(0);
}

class CancellationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancellationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.notifications'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topics')
    ..hasRequiredFields = false
  ;

  CancellationRequest._() : super();
  factory CancellationRequest({
    $core.Iterable<$core.String>? topics,
  }) {
    final _result = create();
    if (topics != null) {
      _result.topics.addAll(topics);
    }
    return _result;
  }
  factory CancellationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancellationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancellationRequest clone() => CancellationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancellationRequest copyWith(void Function(CancellationRequest) updates) => super.copyWith((message) => updates(message as CancellationRequest)) as CancellationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CancellationRequest create() => CancellationRequest._();
  CancellationRequest createEmptyInstance() => create();
  static $pb.PbList<CancellationRequest> createRepeated() => $pb.PbList<CancellationRequest>();
  @$core.pragma('dart2js:noInline')
  static CancellationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancellationRequest>(create);
  static CancellationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get topics => $_getList(0);
}

