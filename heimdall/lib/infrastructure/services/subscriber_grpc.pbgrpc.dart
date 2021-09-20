///
//  Generated code. Do not modify.
//  source: subscriber_grpc.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:chainmetric/models/notifications/subscription.pb.dart' as $3;
import 'package:chainmetric/models/generated/common/status.pb.dart' as $4;
export 'subscriber_grpc.pb.dart';

class SubscriberServiceClient extends $grpc.Client {
  static final _$subscribe =
      $grpc.ClientMethod<$3.SubscriptionRequest, $3.SubscriptionResponse>(
          '/chainmetric.notifications.SubscriberService/subscribe',
          ($3.SubscriptionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $3.SubscriptionResponse.fromBuffer(value));
  static final _$cancel =
      $grpc.ClientMethod<$3.CancellationRequest, $4.StatusResponse>(
          '/chainmetric.notifications.SubscriberService/cancel',
          ($3.CancellationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.StatusResponse.fromBuffer(value));

  SubscriberServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$3.SubscriptionResponse> subscribe(
      $3.SubscriptionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$subscribe, request, options: options);
  }

  $grpc.ResponseFuture<$4.StatusResponse> cancel($3.CancellationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancel, request, options: options);
  }
}

abstract class SubscriberServiceBase extends $grpc.Service {
  $core.String get $name => 'chainmetric.notifications.SubscriberService';

  SubscriberServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$3.SubscriptionRequest, $3.SubscriptionResponse>(
            'subscribe',
            subscribe_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $3.SubscriptionRequest.fromBuffer(value),
            ($3.SubscriptionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.CancellationRequest, $4.StatusResponse>(
        'cancel',
        cancel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.CancellationRequest.fromBuffer(value),
        ($4.StatusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$3.SubscriptionResponse> subscribe_Pre($grpc.ServiceCall call,
      $async.Future<$3.SubscriptionRequest> request) async {
    return subscribe(call, await request);
  }

  $async.Future<$4.StatusResponse> cancel_Pre($grpc.ServiceCall call,
      $async.Future<$3.CancellationRequest> request) async {
    return cancel(call, await request);
  }

  $async.Future<$3.SubscriptionResponse> subscribe(
      $grpc.ServiceCall call, $3.SubscriptionRequest request);
  $async.Future<$4.StatusResponse> cancel(
      $grpc.ServiceCall call, $3.CancellationRequest request);
}
