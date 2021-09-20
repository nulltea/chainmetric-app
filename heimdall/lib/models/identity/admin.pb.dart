///
//  Generated code. Do not modify.
//  source: admin.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'package:chainmetric/models/generated/google/protobuf/timestamp.pb.dart' as $0;

class EnrollUserRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EnrollUserRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.identity'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userID', protoName: 'userID')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role')
    ..aOM<$0.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expireAt', protoName: 'expireAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  EnrollUserRequest._() : super();
  factory EnrollUserRequest({
    $core.String? userID,
    $core.String? role,
    $0.Timestamp? expireAt,
  }) {
    final _result = create();
    if (userID != null) {
      _result.userID = userID;
    }
    if (role != null) {
      _result.role = role;
    }
    if (expireAt != null) {
      _result.expireAt = expireAt;
    }
    return _result;
  }
  factory EnrollUserRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnrollUserRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnrollUserRequest clone() => EnrollUserRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnrollUserRequest copyWith(void Function(EnrollUserRequest) updates) => super.copyWith((message) => updates(message as EnrollUserRequest)) as EnrollUserRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EnrollUserRequest create() => EnrollUserRequest._();
  EnrollUserRequest createEmptyInstance() => create();
  static $pb.PbList<EnrollUserRequest> createRepeated() => $pb.PbList<EnrollUserRequest>();
  @$core.pragma('dart2js:noInline')
  static EnrollUserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EnrollUserRequest>(create);
  static EnrollUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userID => $_getSZ(0);
  @$pb.TagNumber(1)
  set userID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserID() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get role => $_getSZ(1);
  @$pb.TagNumber(2)
  set role($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRole() => clearField(2);

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

class EnrollUserResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EnrollUserResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.identity'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initialPassword', protoName: 'initialPassword')
    ..hasRequiredFields = false
  ;

  EnrollUserResponse._() : super();
  factory EnrollUserResponse({
    $core.String? initialPassword,
  }) {
    final _result = create();
    if (initialPassword != null) {
      _result.initialPassword = initialPassword;
    }
    return _result;
  }
  factory EnrollUserResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnrollUserResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnrollUserResponse clone() => EnrollUserResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnrollUserResponse copyWith(void Function(EnrollUserResponse) updates) => super.copyWith((message) => updates(message as EnrollUserResponse)) as EnrollUserResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EnrollUserResponse create() => EnrollUserResponse._();
  EnrollUserResponse createEmptyInstance() => create();
  static $pb.PbList<EnrollUserResponse> createRepeated() => $pb.PbList<EnrollUserResponse>();
  @$core.pragma('dart2js:noInline')
  static EnrollUserResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EnrollUserResponse>(create);
  static EnrollUserResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get initialPassword => $_getSZ(0);
  @$pb.TagNumber(1)
  set initialPassword($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInitialPassword() => $_has(0);
  @$pb.TagNumber(1)
  void clearInitialPassword() => clearField(1);
}

