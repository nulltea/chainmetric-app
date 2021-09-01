///
//  Generated code. Do not modify.
//  source: identity_grpc.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:chainmetric/models/identity/enrollment.pb.dart' as $2;
export 'identity_grpc.pb.dart';

class IdentityServiceClient extends $grpc.Client {
  static final _$register =
      $grpc.ClientMethod<$2.RegistrationRequest, $2.RegistrationResponse>(
          '/chainmetric.identity.service.IdentityService/register',
          ($2.RegistrationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.RegistrationResponse.fromBuffer(value));
  static final _$enroll =
      $grpc.ClientMethod<$2.EnrollmentRequest, $2.EnrollmentResponse>(
          '/chainmetric.identity.service.IdentityService/enroll',
          ($2.EnrollmentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.EnrollmentResponse.fromBuffer(value));

  IdentityServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.RegistrationResponse> register(
      $2.RegistrationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$register, request, options: options);
  }

  $grpc.ResponseFuture<$2.EnrollmentResponse> enroll(
      $2.EnrollmentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enroll, request, options: options);
  }
}

abstract class IdentityServiceBase extends $grpc.Service {
  $core.String get $name => 'chainmetric.identity.service.IdentityService';

  IdentityServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$2.RegistrationRequest, $2.RegistrationResponse>(
            'register',
            register_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $2.RegistrationRequest.fromBuffer(value),
            ($2.RegistrationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.EnrollmentRequest, $2.EnrollmentResponse>(
        'enroll',
        enroll_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.EnrollmentRequest.fromBuffer(value),
        ($2.EnrollmentResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.RegistrationResponse> register_Pre($grpc.ServiceCall call,
      $async.Future<$2.RegistrationRequest> request) async {
    return register(call, await request);
  }

  $async.Future<$2.EnrollmentResponse> enroll_Pre($grpc.ServiceCall call,
      $async.Future<$2.EnrollmentRequest> request) async {
    return enroll(call, await request);
  }

  $async.Future<$2.RegistrationResponse> register(
      $grpc.ServiceCall call, $2.RegistrationRequest request);
  $async.Future<$2.EnrollmentResponse> enroll(
      $grpc.ServiceCall call, $2.EnrollmentRequest request);
}
