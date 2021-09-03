import 'package:chainmetric/app/pages/organization/enrollment_page.dart';
import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/app/utils/utils.dart' as utils;
import 'package:chainmetric/app/widgets/common/form_button_widget.dart';
import 'package:chainmetric/infrastructure/repositories/certificates_vault.dart';
import 'package:chainmetric/infrastructure/services/admin_grpc.dart';
import 'package:chainmetric/models/identity/user.dart';
import 'package:chainmetric/models/identity/user.pb.dart';
import 'package:chainmetric/platform/repositories/identities_shared.dart';
import 'package:flutter/material.dart';

class CandidatesPage extends StatefulWidget {
  const CandidatesPage({Key? key}) : super(key: key);

  @override
  _CandidatesPageState createState() => _CandidatesPageState();
}

class _CandidatesPageState extends State<CandidatesPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final AppUser adminIdentity;

  List<User>? candidates;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Candidates"),
        ),
        body: _candidatePageView(context));
  }

  Widget _candidatePageView(BuildContext context) => PageView.builder(
        controller: PageController(viewportFraction: 0.93),
        itemCount: candidates?.length ?? 0,
        itemBuilder: _pagerBuilder,
      );

  Widget _pagerBuilder(BuildContext context, int index) {
    final record = candidates?.elementAt(index);

    if (record == null) return const Center();

    return SafeArea(
      child: _candidateCardPage(record),
    );
  }

  Widget _candidateCardPage(User user) => Card(
        elevation: 5,
        margin: const EdgeInsets.only(left: 4, right: 4, bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Center(child: Icon(Icons.account_circle_sharp, size: 128)),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("${user.firstname} ${user.lastname}",
                    style: AppTheme.title1),
              ),
            ),
            ListTile(
                leading: const Icon(Icons.email_sharp),
                title: Text(user.email)),
            const Spacer(),
            Center(
              child: FormButtonWidget(
                onPressed: () => utils.openPage(context,
                    EnrollUserPage(user, onEnroll: (ctx) {
                      Navigator.pop(ctx);
                      _refreshCandidates();
                    })),
                text: "ENROLL",
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
          ]),
        ),
      );

  @override
  void initState() {
    super.initState();
    adminIdentity = IdentitiesRepo.current!;
    _refreshCandidates();
  }

  Future<void> _refreshCandidates() async {
    final resp = await AdminService(adminIdentity.organization,
            certificate: await CertificatesResolver(adminIdentity.organization)
                .resolveBytes("identity-client"),
            accessToken: adminIdentity.accessToken)
        .getCandidates(UsersRequest());

    setState(() {
      candidates = resp.users;
    });
  }
}
