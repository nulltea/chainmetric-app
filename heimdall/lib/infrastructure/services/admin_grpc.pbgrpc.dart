///
//  Generated code. Do not modify.
//  source: admin_grpc.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:chainmetric/models/identity/user.pb.dart' as $1;
import 'package:chainmetric/models/identity/admin.pb.dart' as $2;
export 'admin_grpc.pb.dart';

class AdminServiceClient extends $grpc.Client {
  static final _$getCandidates =
      $grpc.ClientMethod<$1.UsersRequest, $1.UsersResponse>(
          '/chainmetric.identity.AdminService/getCandidates',
          ($1.UsersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.UsersResponse.fromBuffer(value));
  static final _$enrollUser =
      $grpc.ClientMethod<$2.EnrollUserRequest, $2.EnrollUserResponse>(
          '/chainmetric.identity.AdminService/enrollUser',
          ($2.EnrollUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.EnrollUserResponse.fromBuffer(value));

  AdminServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.UsersResponse> getCandidates($1.UsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCandidates, request, options: options);
  }

  $grpc.ResponseFuture<$2.EnrollUserResponse> enrollUser(
      $2.EnrollUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enrollUser, request, options: options);
  }
}

abstract class AdminServiceBase extends $grpc.Service {
  $core.String get $name => 'chainmetric.identity.AdminService';

  AdminServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.UsersRequest, $1.UsersResponse>(
        'getCandidates',
        getCandidates_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.UsersRequest.fromBuffer(value),
        ($1.UsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.EnrollUserRequest, $2.EnrollUserResponse>(
        'enrollUser',
        enrollUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.EnrollUserRequest.fromBuffer(value),
        ($2.EnrollUserResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.UsersResponse> getCandidates_Pre(
      $grpc.ServiceCall call, $async.Future<$1.UsersRequest> request) async {
    return getCandidates(call, await request);
  }

  $async.Future<$2.EnrollUserResponse> enrollUser_Pre($grpc.ServiceCall call,
      $async.Future<$2.EnrollUserRequest> request) async {
    return enrollUser(call, await request);
  }

  $async.Future<$1.UsersResponse> getCandidates(
      $grpc.ServiceCall call, $1.UsersRequest request);
  $async.Future<$2.EnrollUserResponse> enrollUser(
      $grpc.ServiceCall call, $2.EnrollUserRequest request);
}
