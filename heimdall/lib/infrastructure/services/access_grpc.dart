import 'package:chainmetric/infrastructure/services/access_grpc.pbgrpc.dart';
import 'package:grpc/grpc.dart' as grpc;

class AccessService extends AccessServiceClient {
  final String organization;

  AccessService(this.organization,
      {grpc.ClientChannel? channel, List<int>? certificate})
      : super(channel ??
      grpc.ClientChannel("identity.$organization.org.chainmetric.network",
          options: grpc.ChannelOptions(
              credentials: grpc.ChannelCredentials.secure(
                  certificates: certificate))));
}
