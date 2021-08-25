///
//  Generated code. Do not modify.
//  source: auth_grpc.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:chainmetric/models/identity/auth.pb.dart' as $0;
import 'package:chainmetric/models/generated/google/protobuf/empty.pb.dart' as $1;
export 'auth_grpc.pb.dart';

class AuthServiceClient extends $grpc.Client {
  static final _$authenticate =
      $grpc.ClientMethod<$0.AuthRequest, $0.AuthResponse>(
          '/chainmetric.identity.service.AuthService/authenticate',
          ($0.AuthRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.AuthResponse.fromBuffer(value));
  static final _$setPassword =
      $grpc.ClientMethod<$0.SetPasswordRequest, $1.Empty>(
          '/chainmetric.identity.service.AuthService/setPassword',
          ($0.SetPasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  AuthServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.AuthResponse> authenticate($0.AuthRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$authenticate, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> setPassword($0.SetPasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setPassword, request, options: options);
  }
}

abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'chainmetric.identity.service.AuthService';

  AuthServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.AuthRequest, $0.AuthResponse>(
        'authenticate',
        authenticate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AuthRequest.fromBuffer(value),
        ($0.AuthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetPasswordRequest, $1.Empty>(
        'setPassword',
        setPassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SetPasswordRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.AuthResponse> authenticate_Pre(
      $grpc.ServiceCall call, $async.Future<$0.AuthRequest> request) async {
    return authenticate(call, await request);
  }

  $async.Future<$1.Empty> setPassword_Pre($grpc.ServiceCall call,
      $async.Future<$0.SetPasswordRequest> request) async {
    return setPassword(call, await request);
  }

  $async.Future<$0.AuthResponse> authenticate(
      $grpc.ServiceCall call, $0.AuthRequest request);
  $async.Future<$1.Empty> setPassword(
      $grpc.ServiceCall call, $0.SetPasswordRequest request);
}
