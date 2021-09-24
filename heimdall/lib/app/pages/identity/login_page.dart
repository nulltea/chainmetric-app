import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chainmetric/app/pages/identity/registration_page.dart';
import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/app/utils/menus.dart' as menus;
import 'package:chainmetric/app/utils/utils.dart' as utils;
import 'package:chainmetric/app/widgets/common/form_button_widget.dart';
import 'package:chainmetric/app/widgets/common/form_dropdown_widget.dart';
import 'package:chainmetric/platform/repositories/identities_shared.dart';
import 'package:chainmetric/platform/repositories/localdata_json.dart';
import 'package:chainmetric/usecase/identity/login_helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function(BuildContext)? onLogged;

  LoginPage({Key? key, this.onLogged}) : super(key: key ?? GlobalKey());

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? organization;

  String? certificate;
  String? privateKey;
  bool privateKeyVisibility = false;

  String? email;
  String? passcode;
  bool passcodeVisibility = false;

  bool certificateAuth = false;

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
                  'CHAINMETRIC',
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
                        initialOption: organization,
                        icon: const Icon(
                          Icons.corporate_fare_sharp,
                        ),
                        elevation: 2,
                        borderColor: Colors.transparent,
                        borderWidth: 0,
                        borderRadius: 8,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        items: LocalDataRepo.organizations!
                            .map<DropdownMenuItem<String>>(
                                (org) => DropdownMenuItem<String>(
                                      value: org.mspID,
                                      child: Text(org.name),
                                    ))
                            .toList(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "You must specify your organization in order to authenticate";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() => organization = value);
                        },
                      ),
                    ),
                    if (certificateAuth)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter a certificate",
                            labelText: "Certificate",
                            enabledBorder: const UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            suffixIcon: InkWell(
                              onTap: () {},
                              child: const Icon(Icons.attach_file),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "You must provide certificate to identify you";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => certificate = value);
                          },
                          maxLines: 5,
                        ),
                      ),
                    if (certificateAuth)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter a private key",
                            labelText: "Private key",
                            enabledBorder: const UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            suffixIcon: InkWell(
                              onTap: () {},
                              child: const Icon(Icons.attach_file),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "You must provide private key to identify you";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() =>
                                privateKey = value.replaceAll("    ", "\n"));
                          },
                          maxLines: 2,
                        ),
                      ),
                    if (!certificateAuth)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: "Enter your email",
                            labelText: "Email",
                            enabledBorder: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "You must provide email to identify you";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => email = value);
                          },
                        ),
                      ),
                    if (!certificateAuth)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: TextFormField(
                          obscureText: !passcodeVisibility,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter a password",
                            labelText: "Password",
                            enabledBorder: const UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            suffixIcon: InkWell(
                              onTap: () => setState(
                                () => passcodeVisibility =
                                    !passcodeVisibility,
                              ),
                              child: Icon(
                                passcodeVisibility
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "You must provide passcode to identify you";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => passcode = value);
                          },
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: FormButtonWidget(
                        onPressed: submitIdentity,
                        text: "LOGIN",
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
                    TextButton(
                        onPressed: () => setState(() => certificateAuth = !certificateAuth),
                        child: Text(!certificateAuth
                            ? "Login with certificate instead"
                            : "Back to password login")),
                    if (IdentitiesRepo.all.isNotEmpty)
                      TextButton(
                          onPressed: () => menus.switchIdentitiesMenu(context, onSelect: widget.onLogged),
                          child: Text("Use other identity (${IdentitiesRepo.all.length})"))
                  ].expand((widget) => [
                        widget,
                        const SizedBox(
                          height: 12,
                        )
                      ])
                ]),
              ),
              TextButton(
                  onPressed: () => utils.openPage(context, RegistrationPage(onRegister: widget.onLogged)),
                  child: const Text("New here? Request registration here"))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    organization = LocalDataRepo.organizations![0].mspID;
  }

  Future<void> submitIdentity() async {
    if (formKey.currentState!.validate()) {
      final loginHelper = LoginHelper(organization!);
      try {
        if (certificateAuth) {
          if (await loginHelper.loginX509(certificate!, privateKey!)) {
            widget.onLogged?.call(context);
          }
        } else {
          if (await loginHelper.loginUserpass(email!, passcode!)) {
            widget.onLogged?.call(context);
          }
        }
      } on Exception catch (e) {
        utils.displayError(context, e);
      }
    }
  }
}
