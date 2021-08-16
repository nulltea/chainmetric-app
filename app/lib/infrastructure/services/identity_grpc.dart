import 'package:chainmetric/infrastructure/services/identity_grpc.pbgrpc.dart';
import 'package:grpc/grpc.dart' as grpc;

class IdentityService extends IdentityServiceClient {
  final String organization;

  IdentityService(this.organization, {grpc.ClientChannel? channel}) : super(
      channel ?? grpc.ClientChannel("identity.$organization.org.chainmetric.network",
        options: const grpc.ChannelOptions(
            credentials: grpc.ChannelCredentials.insecure()
        ))
  );
}