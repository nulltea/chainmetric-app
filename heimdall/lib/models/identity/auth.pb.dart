///
//  Generated code. Do not modify.
//  source: access.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'package:chainmetric/models/identity/user.pb.dart' as $1;

class FabricCredentialsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FabricCredentialsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.identity.presenter'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'passcode')
    ..hasRequiredFields = false
  ;

  FabricCredentialsRequest._() : super();
  factory FabricCredentialsRequest({
    $core.String? email,
    $core.String? passcode,
  }) {
    final _result = create();
    if (email != null) {
      _result.email = email;
    }
    if (passcode != null) {
      _result.passcode = passcode;
    }
    return _result;
  }
  factory FabricCredentialsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FabricCredentialsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FabricCredentialsRequest clone() => FabricCredentialsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FabricCredentialsRequest copyWith(void Function(FabricCredentialsRequest) updates) => super.copyWith((message) => updates(message as FabricCredentialsRequest)) as FabricCredentialsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FabricCredentialsRequest create() => FabricCredentialsRequest._();
  FabricCredentialsRequest createEmptyInstance() => create();
  static $pb.PbList<FabricCredentialsRequest> createRepeated() => $pb.PbList<FabricCredentialsRequest>();
  @$core.pragma('dart2js:noInline')
  static FabricCredentialsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FabricCredentialsRequest>(create);
  static FabricCredentialsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get passcode => $_getSZ(1);
  @$pb.TagNumber(2)
  set passcode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPasscode() => $_has(1);
  @$pb.TagNumber(2)
  void clearPasscode() => clearField(2);
}

class FabricCredentialsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FabricCredentialsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.identity.presenter'), createEmptyInstance: create)
    ..aOM<VaultSecret>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'secret', subBuilder: VaultSecret.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'apiAccessToken', protoName: 'apiAccessToken')
    ..aOM<$1.User>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: $1.User.create)
    ..hasRequiredFields = false
  ;

  FabricCredentialsResponse._() : super();
  factory FabricCredentialsResponse({
    VaultSecret? secret,
    $core.String? apiAccessToken,
    $1.User? user,
  }) {
    final _result = create();
    if (secret != null) {
      _result.secret = secret;
    }
    if (apiAccessToken != null) {
      _result.apiAccessToken = apiAccessToken;
    }
    if (user != null) {
      _result.user = user;
    }
    return _result;
  }
  factory FabricCredentialsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FabricCredentialsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FabricCredentialsResponse clone() => FabricCredentialsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FabricCredentialsResponse copyWith(void Function(FabricCredentialsResponse) updates) => super.copyWith((message) => updates(message as FabricCredentialsResponse)) as FabricCredentialsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FabricCredentialsResponse create() => FabricCredentialsResponse._();
  FabricCredentialsResponse createEmptyInstance() => create();
  static $pb.PbList<FabricCredentialsResponse> createRepeated() => $pb.PbList<FabricCredentialsResponse>();
  @$core.pragma('dart2js:noInline')
  static FabricCredentialsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FabricCredentialsResponse>(create);
  static FabricCredentialsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  VaultSecret get secret => $_getN(0);
  @$pb.TagNumber(1)
  set secret(VaultSecret v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSecret() => $_has(0);
  @$pb.TagNumber(1)
  void clearSecret() => clearField(1);
  @$pb.TagNumber(1)
  VaultSecret ensureSecret() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get apiAccessToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set apiAccessToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasApiAccessToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearApiAccessToken() => clearField(2);

  @$pb.TagNumber(3)
  $1.User get user => $_getN(2);
  @$pb.TagNumber(3)
  set user($1.User v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearUser() => clearField(3);
  @$pb.TagNumber(3)
  $1.User ensureUser() => $_ensure(2);
}

class VaultSecret extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VaultSecret', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.identity.presenter'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..hasRequiredFields = false
  ;

  VaultSecret._() : super();
  factory VaultSecret({
    $core.String? token,
    $core.String? path,
  }) {
    final _result = create();
    if (token != null) {
      _result.token = token;
    }
    if (path != null) {
      _result.path = path;
    }
    return _result;
  }
  factory VaultSecret.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VaultSecret.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VaultSecret clone() => VaultSecret()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VaultSecret copyWith(void Function(VaultSecret) updates) => super.copyWith((message) => updates(message as VaultSecret)) as VaultSecret; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VaultSecret create() => VaultSecret._();
  VaultSecret createEmptyInstance() => create();
  static $pb.PbList<VaultSecret> createRepeated() => $pb.PbList<VaultSecret>();
  @$core.pragma('dart2js:noInline')
  static VaultSecret getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VaultSecret>(create);
  static VaultSecret? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => clearField(2);
}

class UpdatePasswordRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdatePasswordRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.identity.presenter'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'prevPasscode', protoName: 'prevPasscode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newPasscode', protoName: 'newPasscode')
    ..hasRequiredFields = false
  ;

  UpdatePasswordRequest._() : super();
  factory UpdatePasswordRequest({
    $core.String? prevPasscode,
    $core.String? newPasscode,
  }) {
    final _result = create();
    if (prevPasscode != null) {
      _result.prevPasscode = prevPasscode;
    }
    if (newPasscode != null) {
      _result.newPasscode = newPasscode;
    }
    return _result;
  }
  factory UpdatePasswordRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePasswordRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePasswordRequest clone() => UpdatePasswordRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePasswordRequest copyWith(void Function(UpdatePasswordRequest) updates) => super.copyWith((message) => updates(message as UpdatePasswordRequest)) as UpdatePasswordRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdatePasswordRequest create() => UpdatePasswordRequest._();
  UpdatePasswordRequest createEmptyInstance() => create();
  static $pb.PbList<UpdatePasswordRequest> createRepeated() => $pb.PbList<UpdatePasswordRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdatePasswordRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdatePasswordRequest>(create);
  static UpdatePasswordRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get prevPasscode => $_getSZ(0);
  @$pb.TagNumber(1)
  set prevPasscode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPrevPasscode() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrevPasscode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get newPasscode => $_getSZ(1);
  @$pb.TagNumber(2)
  set newPasscode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewPasscode() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewPasscode() => clearField(2);
}

