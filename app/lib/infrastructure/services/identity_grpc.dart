import 'dart:io';

import 'package:chainmetric/infrastructure/services/identity_grpc.pbgrpc.dart';
import 'package:grpc/grpc.dart' as grpc;

class IdentityService extends IdentityServiceClient {
  final String organization;

  IdentityService(this.organization, {grpc.ClientChannel? channel})
      : super(channel ??
            grpc.ClientChannel("identity.$organization.org.chainmetric.network",
                options: grpc.ChannelOptions(
                    credentials: grpc.ChannelCredentials.secure(
                        certificates:
                            File('assets/certs/ca.pem').readAsBytesSync()))));
}
