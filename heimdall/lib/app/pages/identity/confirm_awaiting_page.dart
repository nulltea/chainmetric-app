import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chainmetric/app/pages/identity/login_page.dart';
import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/app/utils/utils.dart' as utils;
import 'package:chainmetric/app/widgets/common/form_button_widget.dart';
import 'package:chainmetric/infrastructure/repositories/certificates_vault.dart';
import 'package:chainmetric/infrastructure/services/user_grpc.dart';
import 'package:chainmetric/models/generated/google/protobuf/empty.pb.dart';
import 'package:chainmetric/platform/repositories/identities_shared.dart';
import 'package:flutter/material.dart';

class ConfirmAwaitingPage extends StatefulWidget {
  const ConfirmAwaitingPage({Key? key}) : super(key: key);

  @override
  _ConfirmAwaitingPageState createState() => _ConfirmAwaitingPageState();
}

class _ConfirmAwaitingPageState extends State<ConfirmAwaitingPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool alreadyConfirmed = false;

  @override
  Future<void> initState() async {
    super.initState();

    final currentIdentity = IdentitiesRepo.current!;

    final resp = await UserService(currentIdentity.organization,
        certificate: await CertificatesResolver(currentIdentity.organization)
        .resolveBytes("identity-client"))
    .getState(Empty());

    setState(() {
      alreadyConfirmed = resp.confirmed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Column(
            children: [
              ...[
              const Icon(Icons.pending_actions, size: 48), // TODO: Lottie animation here
              AutoSizeText(
                !alreadyConfirmed
                    ? "Your account will be enrolled by administrator soon..."
                    : "Congratulations! Your account has been confirmed",
                textAlign: TextAlign.center,
                style: AppTheme.title1
                    .override(fontSize: 20),
              ),
              if (!alreadyConfirmed) Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: FormButtonWidget(
                        onPressed: () => throw UnimplementedError(),
                        text: "Contact administrator",
                        options: FormButtonOptions(
                          width: 200,
                          height: 50,
                          color: AppTheme.primaryColor,
                          textStyle: AppTheme.subtitle2.override(
                            fontFamily: 'Roboto Mono',
                            color: AppTheme.inputBG,
                            fontWeight: FontWeight.bold,
                          ),
                          elevation: 3,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                if (alreadyConfirmed) Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: FormButtonWidget(
                    onPressed: () => utils.openPage(context, LoginPage()),
                    text: "Start using app...",
                    options: FormButtonOptions(
                      width: 200,
                      height: 50,
                      color: AppTheme.primaryColor,
                      textStyle: AppTheme.subtitle2.override(
                        fontFamily: 'Roboto Mono',
                        color: AppTheme.inputBG,
                        fontWeight: FontWeight.bold,
                      ),
                      elevation: 3,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: 12,
                    ),
                  ),
                )
                  ].expand((widget) => [
                    widget,
                    const SizedBox(
                      height: 12,
                    )
                  ])
                ]),
              ),
          ),
        );
  }

}
