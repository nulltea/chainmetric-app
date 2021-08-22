import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/app/utils/utils.dart' as utils;
import 'package:chainmetric/app/widgets/common/form_button_widget.dart';
import 'package:chainmetric/app/widgets/common/form_dropdown_widget.dart';
import 'package:chainmetric/infrastructure/repositories/certificates_vault.dart';
import 'package:chainmetric/infrastructure/services/identity_grpc.dart';
import 'package:chainmetric/models/identity/enrollment.pb.dart';
import 'package:chainmetric/platform/repositories/localdata_json.dart';
import 'package:chainmetric/platform/repositories/preferences_shared.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  RegistrationRequest request = RegistrationRequest();
  String? organization;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height:
                    max(100, 250 - MediaQuery.of(context).viewInsets.bottom),
                alignment: Alignment.center,
                decoration: const BoxDecoration(),
                child: AutoSizeText(
                  'Registation',
                  textAlign: TextAlign.center,
                  style: AppTheme.title1
                      .override(fontFamily: "IBM Plex Mono", fontSize: 48),
                ),
              ),
              Expanded(
                child: Column(children: [
                  ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: FormDropDownWidget(
                        height: 50,
                        icon: const Icon(
                          Icons.corporate_fare_sharp,
                        ),
                        initialOption: organization,
                        elevation: 2,
                        borderColor: Colors.transparent,
                        borderWidth: 0,
                        borderRadius: 8,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        items: LocalData.organizations!
                            .map<DropdownMenuItem<String>>(
                                (org) => DropdownMenuItem<String>(
                                      value: org.mspID,
                                      child: Text(org.name!),
                                    ))
                            .toList(),
                        onChanged: (value) {
                          setState(() => organization = value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: "Enter your first name",
                          labelText: "Firstname",
                          enabledBorder: UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "You must provide your initials for registration";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() => request.firstname = value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: "Enter your last name",
                          labelText: "Lastname",
                          enabledBorder: UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "You must provide your initials for registration";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() => request.lastname = value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: "Enter your email address",
                          labelText: "Email",
                          enabledBorder: UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "You must provide your email for registration";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() => request.email = value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: FormButtonWidget(
                        onPressed: submitRegistration,
                        text: "REGISTER",
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    organization = LocalData.organizations![0].mspID;
  }

  Future<void> submitRegistration() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      final response = await IdentityService(organization!,
              certificate: await CerificatesResolver(organization!)
                  .resolveBytes("identity-client"))
          .register(request);

      Preferences.accessToken = response.accessToken;
    } on Exception catch (e) {
      utils.displayError(context, e);
    }
  }
}
