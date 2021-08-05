import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chainmetric/controllers/references_adapter.dart';
import 'package:chainmetric/views/components/form_button_widget.dart';
import 'package:chainmetric/views/components/form_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:chainmetric/controllers/blockchain_adapter.dart';
import 'package:chainmetric/models/auth_model.dart';
import 'package:chainmetric/main_theme.dart';

class AuthPage extends StatefulWidget {
  final Function submitAuth;

  const AuthPage({Key key, this.submitAuth}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthCredentials credentials = AuthCredentials();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool privateKeyVisibility = false;

  Future<void> submitIdentity() async {
    if (formKey.currentState.validate()) {
      try {
        if (await Blockchain.authenticate(credentials)) {
          widget.submitAuth();
        }
      } on Exception catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
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
              Container(
                height: max(100, 250 - MediaQuery.of(context).viewInsets.bottom),
                alignment: Alignment.center,
                decoration: const BoxDecoration(),
                child: AutoSizeText(
                  'CHAINMETRIC',
                  textAlign: TextAlign.center,
                  style: AppTheme.title1.override(
                      fontFamily: "IBM Plex Mono", fontSize: 48),
                ),
              ),
              Expanded(
                child: Column(
                    children: [
                  ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: FormDropDownWidget(
                        height: 50,
                        icon: const Icon(
                          Icons.corporate_fare_sharp,
                        ),
                        elevation: 2,
                        borderColor: Colors.transparent,
                        borderWidth: 0,
                        borderRadius: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        items: References.organizations
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
                          setState(() => credentials.organization = value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: "Enter a certificate",
                          labelText: "Certificate",
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "You must provide certificate to identify you";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() => credentials.certificate = value);
                        },
                        maxLines: 5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextFormField(
                        obscureText: !privateKeyVisibility,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Enter a private key",
                          labelText: "Private key",
                          enabledBorder: const UnderlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          suffixIcon: InkWell(
                            onTap: () => setState(
                              () => privateKeyVisibility = !privateKeyVisibility,
                            ),
                            child: Icon(
                              privateKeyVisibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "You must provide private key to identify you";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() => credentials.privateKey = value);
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
                          textStyle:
                          AppTheme.subtitle2.override(
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
}
