import 'package:grpc/grpc.dart' as grpc;
import 'package:global_configuration/global_configuration.dart';
import 'package:chainmetric/infrastructure/services/middlewares/jwt_grpc.dart';
import 'package:chainmetric/infrastructure/services/user_grpc.pbgrpc.dart';

class UserService extends UserServiceClient {
  final String organization;

  UserService(this.organization,
      {grpc.ClientChannel? channel,
      List<int>? certificate,
      String? accessToken})
      : super(
            channel ??
                grpc.ClientChannel(
                    "identity.$organization.org.${GlobalConfiguration().getValue("grpc_domain")}",
                    options: grpc.ChannelOptions(
                        credentials: grpc.ChannelCredentials.secure(
                            certificates: certificate))),
            interceptors:
                accessToken != null ? [JWTAuthInterceptor(accessToken)] : null);
}
