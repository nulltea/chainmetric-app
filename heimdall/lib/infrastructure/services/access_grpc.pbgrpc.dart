///
//  Generated code. Do not modify.
//  source: access_grpc.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:chainmetric/models/identity/auth.pb.dart' as $0;
import 'package:chainmetric/models/identity/common.pb.dart' as $1;
export 'access_grpc.pb.dart';

class AccessServiceClient extends $grpc.Client {
  static final _$requestFabricCredentials = $grpc.ClientMethod<
          $0.FabricCredentialsRequest, $0.FabricCredentialsResponse>(
      '/chainmetric.identity.service.AccessService/requestFabricCredentials',
      ($0.FabricCredentialsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.FabricCredentialsResponse.fromBuffer(value));
  static final _$updatePassword =
      $grpc.ClientMethod<$0.UpdatePasswordRequest, $1.StatusResponse>(
          '/chainmetric.identity.service.AccessService/updatePassword',
          ($0.UpdatePasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.StatusResponse.fromBuffer(value));

  AccessServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.FabricCredentialsResponse> requestFabricCredentials(
      $0.FabricCredentialsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestFabricCredentials, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.StatusResponse> updatePassword(
      $0.UpdatePasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePassword, request, options: options);
  }
}

abstract class AccessServiceBase extends $grpc.Service {
  $core.String get $name => 'chainmetric.identity.service.AccessService';

  AccessServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.FabricCredentialsRequest,
            $0.FabricCredentialsResponse>(
        'requestFabricCredentials',
        requestFabricCredentials_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.FabricCredentialsRequest.fromBuffer(value),
        ($0.FabricCredentialsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdatePasswordRequest, $1.StatusResponse>(
        'updatePassword',
        updatePassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdatePasswordRequest.fromBuffer(value),
        ($1.StatusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.FabricCredentialsResponse> requestFabricCredentials_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.FabricCredentialsRequest> request) async {
    return requestFabricCredentials(call, await request);
  }

  $async.Future<$1.StatusResponse> updatePassword_Pre($grpc.ServiceCall call,
      $async.Future<$0.UpdatePasswordRequest> request) async {
    return updatePassword(call, await request);
  }

  $async.Future<$0.FabricCredentialsResponse> requestFabricCredentials(
      $grpc.ServiceCall call, $0.FabricCredentialsRequest request);
  $async.Future<$1.StatusResponse> updatePassword(
      $grpc.ServiceCall call, $0.UpdatePasswordRequest request);
}
