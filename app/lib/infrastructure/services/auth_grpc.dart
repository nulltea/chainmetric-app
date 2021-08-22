import 'package:chainmetric/infrastructure/services/auth_grpc.pbgrpc.dart';
import 'package:grpc/grpc.dart' as grpc;

class AuthService extends AuthServiceClient {
  final String organization;

  AuthService(this.organization,
      {grpc.ClientChannel? channel, List<int>? certificate})
      : super(channel ??
      grpc.ClientChannel("identity.$organization.org.chainmetric.network",
          options: grpc.ChannelOptions(
              credentials: grpc.ChannelCredentials.secure(
                  certificates: certificate))));
}
