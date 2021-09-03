import 'package:chainmetric/models/identity/user.dart';
import 'package:chainmetric/models/identity/user.pb.dart';
import 'package:chainmetric/usecase/identity/login_helper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chainmetric/app/pages/identity/login_page.dart';
import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/app/utils/utils.dart' as utils;
import 'package:chainmetric/app/utils/menus.dart' as menus;
import 'package:chainmetric/app/widgets/common/form_button_widget.dart';
import 'package:chainmetric/infrastructure/repositories/certificates_vault.dart';
import 'package:chainmetric/infrastructure/services/user_grpc.dart';
import 'package:chainmetric/models/generated/google/protobuf/empty.pb.dart';
import 'package:chainmetric/platform/repositories/identities_shared.dart';

class ConfirmPendingPage extends StatefulWidget {
  final Function(BuildContext)? onReady;

  const ConfirmPendingPage({Key? key, this.onReady}) : super(key: key);

  @override
  _ConfirmPendingPageState createState() => _ConfirmPendingPageState();
}

class _ConfirmPendingPageState extends State<ConfirmPendingPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool pendingConfirm = true;
  late final AppUser currentIdentity;
  late final String initialPassword;

  @override
  void initState() {
    super.initState();
    currentIdentity = IdentitiesRepo.current!;

    Future.doWhile(() async {
      final resp = await UserService(currentIdentity.organization,
          certificate:
          await CertificatesResolver(currentIdentity.organization)
              .resolveBytes("identity-client"),
          accessToken: currentIdentity.accessToken)
          .pingAccountStatus(Empty());

      setState(() {
        pendingConfirm = resp.status == UserStatus.PENDING_APPROVAL;
      });

      if (resp.status == UserStatus.APPROVED) {
        IdentitiesRepo.put(currentIdentity
          ..confirmed = true
            ..role = resp.role);
        initialPassword = resp.initialPassword;

        return false;
      }

      await Future.delayed(const Duration(seconds: 10));

      return true;
    });
    // TODO: stop loop on exit
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
                  ? "assets/lottie/review.json"
                  : "assets/lottie/confirmed.json"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AutoSizeText(
                  pendingConfirm
                      ? "Your account will be reviewed by administrator soon"
                      : "Congratulations!\nYour account has been confirmed",
                  textAlign: TextAlign.center,
                  style: AppTheme.title1
                      .override(fontFamily: "IBM Plex Mono", fontSize: 20),
                ),
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
                    text: "Start using app",
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
              if (IdentitiesRepo.all.length > 1)
                TextButton(
                    onPressed: () => menus.switchIdentitiesMenu(context,
                        onSelect: widget.onReady),
                    child: Text(
                        "Use other identity (${IdentitiesRepo.all.length})"))
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

  Future<void> _finishRegistration() async {
    try {
      if (await LoginHelper(currentIdentity.organization)
          .loginUserpass(currentIdentity.email, initialPassword)) {
        IdentitiesRepo.initialPassword = initialPassword;
        // TODO expose initial password to user and propose to change it.
        widget.onReady?.call(context);
      }
    } on Exception catch (e) {
      utils.displayError(context, e);
    }
  }
}
