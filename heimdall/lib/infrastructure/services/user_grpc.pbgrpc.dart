///
//  Generated code. Do not modify.
//  source: user_grpc.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:chainmetric/models/identity/user.pb.dart' as $1;
import 'package:chainmetric/models/generated/google/protobuf/empty.pb.dart' as $3;
import 'package:chainmetric/models/identity/common.pb.dart' as $4;
export 'user_grpc.pb.dart';

class UserServiceClient extends $grpc.Client {
  static final _$register =
      $grpc.ClientMethod<$1.RegistrationRequest, $1.RegistrationResponse>(
          '/chainmetric.identity.service.UserService/register',
          ($1.RegistrationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.RegistrationResponse.fromBuffer(value));
  static final _$getState = $grpc.ClientMethod<$3.Empty, $1.User>(
      '/chainmetric.identity.service.UserService/getState',
      ($3.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.User.fromBuffer(value));
  static final _$changePassword =
      $grpc.ClientMethod<$1.ChangePasswordRequest, $4.StatusResponse>(
          '/chainmetric.identity.service.UserService/changePassword',
          ($1.ChangePasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.StatusResponse.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.RegistrationResponse> register(
      $1.RegistrationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$register, request, options: options);
  }

  $grpc.ResponseFuture<$1.User> getState($3.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getState, request, options: options);
  }

  $grpc.ResponseFuture<$4.StatusResponse> changePassword(
      $1.ChangePasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$changePassword, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'chainmetric.identity.service.UserService';

  UserServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$1.RegistrationRequest, $1.RegistrationResponse>(
            'register',
            register_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.RegistrationRequest.fromBuffer(value),
            ($1.RegistrationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.Empty, $1.User>(
        'getState',
        getState_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.Empty.fromBuffer(value),
        ($1.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChangePasswordRequest, $4.StatusResponse>(
        'changePassword',
        changePassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ChangePasswordRequest.fromBuffer(value),
        ($4.StatusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.RegistrationResponse> register_Pre($grpc.ServiceCall call,
      $async.Future<$1.RegistrationRequest> request) async {
    return register(call, await request);
  }

  $async.Future<$1.User> getState_Pre(
      $grpc.ServiceCall call, $async.Future<$3.Empty> request) async {
    return getState(call, await request);
  }

  $async.Future<$4.StatusResponse> changePassword_Pre($grpc.ServiceCall call,
      $async.Future<$1.ChangePasswordRequest> request) async {
    return changePassword(call, await request);
  }

  $async.Future<$1.RegistrationResponse> register(
      $grpc.ServiceCall call, $1.RegistrationRequest request);
  $async.Future<$1.User> getState($grpc.ServiceCall call, $3.Empty request);
  $async.Future<$4.StatusResponse> changePassword(
      $grpc.ServiceCall call, $1.ChangePasswordRequest request);
}
