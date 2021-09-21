import 'package:grpc/grpc.dart' as grpc;
import 'package:global_configuration/global_configuration.dart';
import 'package:chainmetric/infrastructure/services/subscriber_grpc.pbgrpc.dart';
import 'package:chainmetric/infrastructure/services/middlewares/jwt_grpc.dart';
import 'package:chainmetric/infrastructure/services/middlewares/firebase_grpc.dart';

class SubscriberService extends SubscriberServiceClient {
  final String organization;

  SubscriberService(this.organization,
      {grpc.ClientChannel? channel,
        List<int>? certificate,
        String? accessToken,
        String? firebaseToken})
      : super(
      channel ??
          grpc.ClientChannel(
              "notifications.$organization.org.${GlobalConfiguration().getValue("grpc_domain")}",
              options: grpc.ChannelOptions(
                  credentials: grpc.ChannelCredentials.secure(
                      certificates: certificate))),
      interceptors: [
        if (accessToken != null) JWTAuthInterceptor(accessToken),
        if (firebaseToken != null) PutFirebaseTokenInterceptor(firebaseToken)
      ]);
}
