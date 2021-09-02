import 'package:grpc/grpc.dart' as grpc;

class JWTAuthInterceptor implements grpc.ClientInterceptor {
  final String accessToken;

  JWTAuthInterceptor(this.accessToken);

  @override
  grpc.ResponseFuture<R> interceptUnary<Q, R>(grpc.ClientMethod<Q, R> method, Q request, grpc.CallOptions options, grpc.ClientUnaryInvoker<Q, R> invoker) {
    return invoker(method, request, options.mergedWith(grpc.CallOptions(
      metadata: {"authorization": accessToken}
    )));
  }

  @override
  grpc.ResponseStream<R> interceptStreaming<Q, R>(grpc.ClientMethod<Q, R> method, Stream<Q> requests, grpc.CallOptions options, grpc.ClientStreamingInvoker<Q, R> invoker) {
    return invoker(method, requests, options.mergedWith(grpc.CallOptions(
        metadata: {"authorization": accessToken}
    )));
  }
}