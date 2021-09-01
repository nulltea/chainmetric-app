import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chainmetric/app/pages/identity/login_page.dart';
import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/app/utils/utils.dart' as utils;
import 'package:chainmetric/app/widgets/common/form_button_widget.dart';
import 'package:chainmetric/infrastructure/repositories/certificates_vault.dart';
import 'package:chainmetric/infrastructure/services/user_grpc.dart';
import 'package:chainmetric/models/generated/google/protobuf/empty.pb.dart';
import 'package:chainmetric/platform/repositories/identities_shared.dart';

class ConfirmPendingPage extends StatefulWidget {
  final Function? onReady;

  const ConfirmPendingPage({Key? key, this.onReady}) : super(key: key);

  @override
  _ConfirmPendingPageState createState() => _ConfirmPendingPageState();
}

class _ConfirmPendingPageState extends State<ConfirmPendingPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool pendingConfirm = false;

  @override
  Future<void> initState() async {
    super.initState();

    final currentIdentity = IdentitiesRepo.current!;

    final resp = await UserService(currentIdentity.organization,
            certificate:
                await CertificatesResolver(currentIdentity.organization)
                    .resolveBytes("identity-client"),
            accessToken: currentIdentity.accessToken)
        .getState(Empty());

    setState(() {
      pendingConfirm = !resp.confirmed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Column(children: [
            ...[
              Lottie.asset(pendingConfirm
                  ? "assets/lottie/waiting.json"
                  : "assets/lottie/confirmed.json"), // TODO: Lottie animation here
              AutoSizeText(
                pendingConfirm
                    ? "Your account will be reviewed by administrator soon..."
                    : "Congratulations! Your account has been confirmed",
                textAlign: TextAlign.center,
                style: AppTheme.title1.override(fontSize: 20),
              ),
              if (pendingConfirm)
                Padding(
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
              if (!pendingConfirm)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: FormButtonWidget(
                    onPressed: _finishRegistration,
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

  void _finishRegistration() {
    utils.openPage(context, LoginPage(onLogged: widget.onReady));
  }
}
