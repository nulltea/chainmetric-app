///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'User', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.identity.proto.presenter'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmed')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', protoName: 'createdAt')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expireAt', protoName: 'expireAt')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstname')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastname')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role')
    ..hasRequiredFields = false
  ;

  User._() : super();
  factory User({
    $core.bool? confirmed,
    $core.String? createdAt,
    $core.String? email,
    $core.String? expireAt,
    $core.String? firstname,
    $core.String? id,
    $core.String? lastname,
    $core.String? role,
  }) {
    final _result = create();
    if (confirmed != null) {
      _result.confirmed = confirmed;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (email != null) {
      _result.email = email;
    }
    if (expireAt != null) {
      _result.expireAt = expireAt;
    }
    if (firstname != null) {
      _result.firstname = firstname;
    }
    if (id != null) {
      _result.id = id;
    }
    if (lastname != null) {
      _result.lastname = lastname;
    }
    if (role != null) {
      _result.role = role;
    }
    return _result;
  }
  factory User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User)) as User; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get confirmed => $_getBF(0);
  @$pb.TagNumber(1)
  set confirmed($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasConfirmed() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfirmed() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get createdAt => $_getSZ(1);
  @$pb.TagNumber(2)
  set createdAt($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCreatedAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatedAt() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);

  @$pb.TagNumber(5)
  $core.String get expireAt => $_getSZ(3);
  @$pb.TagNumber(5)
  set expireAt($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpireAt() => $_has(3);
  @$pb.TagNumber(5)
  void clearExpireAt() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get firstname => $_getSZ(4);
  @$pb.TagNumber(6)
  set firstname($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasFirstname() => $_has(4);
  @$pb.TagNumber(6)
  void clearFirstname() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get id => $_getSZ(5);
  @$pb.TagNumber(7)
  set id($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasId() => $_has(5);
  @$pb.TagNumber(7)
  void clearId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get lastname => $_getSZ(6);
  @$pb.TagNumber(8)
  set lastname($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasLastname() => $_has(6);
  @$pb.TagNumber(8)
  void clearLastname() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get role => $_getSZ(7);
  @$pb.TagNumber(9)
  set role($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasRole() => $_has(7);
  @$pb.TagNumber(9)
  void clearRole() => clearField(9);
}

class RegistrationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RegistrationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.identity.proto.presenter'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstname')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastname')
    ..hasRequiredFields = false
  ;

  RegistrationRequest._() : super();
  factory RegistrationRequest({
    $core.String? email,
    $core.String? firstname,
    $core.String? lastname,
  }) {
    final _result = create();
    if (email != null) {
      _result.email = email;
    }
    if (firstname != null) {
      _result.firstname = firstname;
    }
    if (lastname != null) {
      _result.lastname = lastname;
    }
    return _result;
  }
  factory RegistrationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegistrationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegistrationRequest clone() => RegistrationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegistrationRequest copyWith(void Function(RegistrationRequest) updates) => super.copyWith((message) => updates(message as RegistrationRequest)) as RegistrationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegistrationRequest create() => RegistrationRequest._();
  RegistrationRequest createEmptyInstance() => create();
  static $pb.PbList<RegistrationRequest> createRepeated() => $pb.PbList<RegistrationRequest>();
  @$core.pragma('dart2js:noInline')
  static RegistrationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegistrationRequest>(create);
  static RegistrationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get firstname => $_getSZ(1);
  @$pb.TagNumber(2)
  set firstname($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFirstname() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirstname() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get lastname => $_getSZ(2);
  @$pb.TagNumber(3)
  set lastname($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLastname() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastname() => clearField(3);
}

class EnrollmentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EnrollmentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.identity.proto.presenter'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userID', protoName: 'userID')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expireAt', protoName: 'expireAt')
    ..hasRequiredFields = false
  ;

  EnrollmentRequest._() : super();
  factory EnrollmentRequest({
    $core.String? userID,
    $core.String? role,
    $core.String? expireAt,
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
  factory EnrollmentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnrollmentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnrollmentRequest clone() => EnrollmentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnrollmentRequest copyWith(void Function(EnrollmentRequest) updates) => super.copyWith((message) => updates(message as EnrollmentRequest)) as EnrollmentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EnrollmentRequest create() => EnrollmentRequest._();
  EnrollmentRequest createEmptyInstance() => create();
  static $pb.PbList<EnrollmentRequest> createRepeated() => $pb.PbList<EnrollmentRequest>();
  @$core.pragma('dart2js:noInline')
  static EnrollmentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EnrollmentRequest>(create);
  static EnrollmentRequest? _defaultInstance;

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
  $core.String get expireAt => $_getSZ(2);
  @$pb.TagNumber(3)
  set expireAt($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpireAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpireAt() => clearField(3);
}

