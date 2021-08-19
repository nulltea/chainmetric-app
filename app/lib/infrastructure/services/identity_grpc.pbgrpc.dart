///
//  Generated code. Do not modify.
//  source: identity_grpc.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:chainmetric/models/identity/user.pb.dart' as $0;
import 'package:chainmetric/models/generated/google/protobuf/empty.pb.dart'
    as $1;
export 'identity_grpc.pb.dart';

class IdentityServiceClient extends $grpc.Client {
  static final _$register = $grpc.ClientMethod<$0.RegistrationRequest, $0.User>(
      '/chainmetric.identity.service.IdentityService/register',
      ($0.RegistrationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.User.fromBuffer(value));
  static final _$enroll = $grpc.ClientMethod<$0.EnrollmentRequest, $1.Empty>(
      '/chainmetric.identity.service.IdentityService/enroll',
      ($0.EnrollmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  IdentityServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.User> register($0.RegistrationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$register, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> enroll($0.EnrollmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enroll, request, options: options);
  }
}

abstract class IdentityServiceBase extends $grpc.Service {
  $core.String get $name => 'chainmetric.identity.service.IdentityService';

  IdentityServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RegistrationRequest, $0.User>(
        'register',
        register_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RegistrationRequest.fromBuffer(value),
        ($0.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EnrollmentRequest, $1.Empty>(
        'enroll',
        enroll_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EnrollmentRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.User> register_Pre($grpc.ServiceCall call,
      $async.Future<$0.RegistrationRequest> request) async {
    return register(call, await request);
  }

  $async.Future<$1.Empty> enroll_Pre($grpc.ServiceCall call,
      $async.Future<$0.EnrollmentRequest> request) async {
    return enroll(call, await request);
  }

  $async.Future<$0.User> register(
      $grpc.ServiceCall call, $0.RegistrationRequest request);
  $async.Future<$1.Empty> enroll(
      $grpc.ServiceCall call, $0.EnrollmentRequest request);
}
