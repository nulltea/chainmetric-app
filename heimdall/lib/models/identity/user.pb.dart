///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'package:chainmetric/models/generated/google/protobuf/timestamp.pb.dart' as $0;

class User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'User', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.identity.presenter'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstname')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastname')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role')
    ..aOM<$0.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', protoName: 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmed')
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'trained')
    ..aOM<$0.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expireAt', protoName: 'expireAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  User._() : super();
  factory User({
    $core.String? id,
    $core.String? username,
    $core.String? firstname,
    $core.String? lastname,
    $core.String? email,
    $core.String? role,
    $0.Timestamp? createdAt,
    $core.bool? confirmed,
    $core.bool? trained,
    $0.Timestamp? expireAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (username != null) {
      _result.username = username;
    }
    if (firstname != null) {
      _result.firstname = firstname;
    }
    if (lastname != null) {
      _result.lastname = lastname;
    }
    if (email != null) {
      _result.email = email;
    }
    if (role != null) {
      _result.role = role;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (confirmed != null) {
      _result.confirmed = confirmed;
    }
    if (trained != null) {
      _result.trained = trained;
    }
    if (expireAt != null) {
      _result.expireAt = expireAt;
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
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get firstname => $_getSZ(2);
  @$pb.TagNumber(3)
  set firstname($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFirstname() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstname() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastname => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastname($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLastname() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastname() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get role => $_getSZ(5);
  @$pb.TagNumber(6)
  set role($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRole() => $_has(5);
  @$pb.TagNumber(6)
  void clearRole() => clearField(6);

  @$pb.TagNumber(7)
  $0.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($0.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $0.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.bool get confirmed => $_getBF(7);
  @$pb.TagNumber(8)
  set confirmed($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasConfirmed() => $_has(7);
  @$pb.TagNumber(8)
  void clearConfirmed() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get trained => $_getBF(8);
  @$pb.TagNumber(9)
  set trained($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTrained() => $_has(8);
  @$pb.TagNumber(9)
  void clearTrained() => clearField(9);

  @$pb.TagNumber(10)
  $0.Timestamp get expireAt => $_getN(9);
  @$pb.TagNumber(10)
  set expireAt($0.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasExpireAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpireAt() => clearField(10);
  @$pb.TagNumber(10)
  $0.Timestamp ensureExpireAt() => $_ensure(9);
}

class UsersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UsersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.identity.presenter'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  UsersRequest._() : super();
  factory UsersRequest() => create();
  factory UsersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UsersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UsersRequest clone() => UsersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UsersRequest copyWith(void Function(UsersRequest) updates) => super.copyWith((message) => updates(message as UsersRequest)) as UsersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UsersRequest create() => UsersRequest._();
  UsersRequest createEmptyInstance() => create();
  static $pb.PbList<UsersRequest> createRepeated() => $pb.PbList<UsersRequest>();
  @$core.pragma('dart2js:noInline')
  static UsersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UsersRequest>(create);
  static UsersRequest? _defaultInstance;
}

class UsersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UsersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.identity.presenter'), createEmptyInstance: create)
    ..pc<User>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'users', $pb.PbFieldType.PM, subBuilder: User.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'count')
    ..hasRequiredFields = false
  ;

  UsersResponse._() : super();
  factory UsersResponse({
    $core.Iterable<User>? users,
    $fixnum.Int64? count,
  }) {
    final _result = create();
    if (users != null) {
      _result.users.addAll(users);
    }
    if (count != null) {
      _result.count = count;
    }
    return _result;
  }
  factory UsersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UsersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UsersResponse clone() => UsersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UsersResponse copyWith(void Function(UsersResponse) updates) => super.copyWith((message) => updates(message as UsersResponse)) as UsersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UsersResponse create() => UsersResponse._();
  UsersResponse createEmptyInstance() => create();
  static $pb.PbList<UsersResponse> createRepeated() => $pb.PbList<UsersResponse>();
  @$core.pragma('dart2js:noInline')
  static UsersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UsersResponse>(create);
  static UsersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<User> get users => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get count => $_getI64(1);
  @$pb.TagNumber(2)
  set count($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCount() => clearField(2);
}

class RegistrationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RegistrationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.identity.presenter'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstname')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastname')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..hasRequiredFields = false
  ;

  RegistrationRequest._() : super();
  factory RegistrationRequest({
    $core.String? firstname,
    $core.String? lastname,
    $core.String? email,
  }) {
    final _result = create();
    if (firstname != null) {
      _result.firstname = firstname;
    }
    if (lastname != null) {
      _result.lastname = lastname;
    }
    if (email != null) {
      _result.email = email;
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
  $core.String get firstname => $_getSZ(0);
  @$pb.TagNumber(1)
  set firstname($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFirstname() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstname() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get lastname => $_getSZ(1);
  @$pb.TagNumber(2)
  set lastname($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLastname() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastname() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);
}

class RegistrationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RegistrationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.identity.presenter'), createEmptyInstance: create)
    ..aOM<User>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessToken', protoName: 'accessToken')
    ..hasRequiredFields = false
  ;

  RegistrationResponse._() : super();
  factory RegistrationResponse({
    User? user,
    $core.String? accessToken,
  }) {
    final _result = create();
    if (user != null) {
      _result.user = user;
    }
    if (accessToken != null) {
      _result.accessToken = accessToken;
    }
    return _result;
  }
  factory RegistrationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegistrationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegistrationResponse clone() => RegistrationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegistrationResponse copyWith(void Function(RegistrationResponse) updates) => super.copyWith((message) => updates(message as RegistrationResponse)) as RegistrationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegistrationResponse create() => RegistrationResponse._();
  RegistrationResponse createEmptyInstance() => create();
  static $pb.PbList<RegistrationResponse> createRepeated() => $pb.PbList<RegistrationResponse>();
  @$core.pragma('dart2js:noInline')
  static RegistrationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegistrationResponse>(create);
  static RegistrationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get accessToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set accessToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccessToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccessToken() => clearField(2);
}

class ChangePasswordRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ChangePasswordRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chainmetric.identity.presenter'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'prevPasscode', protoName: 'prevPasscode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newPasscode', protoName: 'newPasscode')
    ..hasRequiredFields = false
  ;

  ChangePasswordRequest._() : super();
  factory ChangePasswordRequest({
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
  factory ChangePasswordRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangePasswordRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChangePasswordRequest clone() => ChangePasswordRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChangePasswordRequest copyWith(void Function(ChangePasswordRequest) updates) => super.copyWith((message) => updates(message as ChangePasswordRequest)) as ChangePasswordRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChangePasswordRequest create() => ChangePasswordRequest._();
  ChangePasswordRequest createEmptyInstance() => create();
  static $pb.PbList<ChangePasswordRequest> createRepeated() => $pb.PbList<ChangePasswordRequest>();
  @$core.pragma('dart2js:noInline')
  static ChangePasswordRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangePasswordRequest>(create);
  static ChangePasswordRequest? _defaultInstance;

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

