import 'package:grpc/grpc.dart' as grpc;

class PutFirebaseTokenInterceptor implements grpc.ClientInterceptor {
  final String token;

  PutFirebaseTokenInterceptor(this.token);

  @override
  grpc.ResponseFuture<R> interceptUnary<Q, R>(grpc.ClientMethod<Q, R> method, Q request, grpc.CallOptions options, grpc.ClientUnaryInvoker<Q, R> invoker) {
    return invoker(method, request, options.mergedWith(grpc.CallOptions(
      metadata: {"firebase_token": token}
    )));
  }

  @override
  grpc.ResponseStream<R> interceptStreaming<Q, R>(grpc.ClientMethod<Q, R> method, Stream<Q> requests, grpc.CallOptions options, grpc.ClientStreamingInvoker<Q, R> invoker) {
    return invoker(method, requests, options.mergedWith(grpc.CallOptions(
        metadata: {"firebase_token": token}
    )));
  }
}