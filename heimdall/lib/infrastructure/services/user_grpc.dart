import 'package:chainmetric/infrastructure/services/user_grpc.pbgrpc.dart';
import 'package:chainmetric/models/generated/google/protobuf/empty.pb.dart';
import 'package:chainmetric/models/identity/user.pb.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:grpc/grpc.dart';

class UserService extends UserServiceClient {
  final String organization;

  UserService(this.organization,
      {grpc.ClientChannel? channel, List<int>? certificate})
      : super(channel ??
      grpc.ClientChannel("identity.$organization.org.${GlobalConfiguration().getValue("grpc_domain")}",
          options: grpc.ChannelOptions(
              credentials: grpc.ChannelCredentials.secure(
                  certificates: certificate))));
}
