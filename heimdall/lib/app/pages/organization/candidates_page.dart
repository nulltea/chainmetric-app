import 'package:chainmetric/app/utils/utils.dart' as utils;
import 'package:chainmetric/infrastructure/repositories/certificates_vault.dart';
import 'package:chainmetric/infrastructure/services/identity_grpc.dart';
import 'package:chainmetric/models/identity/user.pb.dart';
import 'package:flutter/material.dart';

class CandidatesPage extends StatefulWidget {
  const CandidatesPage({Key? key}) : super(key: key);

  @override
  _CandidatesPageState createState() => _CandidatesPageState();
}

class _CandidatesPageState extends State<CandidatesPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final PageController _controller;

  late List<User> candidates;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Candidates"),
      ),
      body: _candidatePageView(context)
    );
  }

  Widget _candidatePageView(BuildContext context) => PageView.builder(
    controller: _controller = PageController(viewportFraction: 0.93),
    itemCount: candidates.length ?? 0,
    itemBuilder: _pagerBuilder,
    onPageChanged: _onPageChanged,
  );

  Widget _pagerBuilder(BuildContext context, int index) {
    final record = candidates.elementAt(index);
    return SafeArea(
      child: _candidateCardPage(record),
    );
  }

  Widget _candidateCardPage(User user) =>
      Card(
        elevation: 5,
        margin: const EdgeInsets.only(left: 4, right: 4, bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: []
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
  }

  void _onPageChanged(int value) {
  }
}
