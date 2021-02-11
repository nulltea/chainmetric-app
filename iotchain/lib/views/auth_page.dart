import 'package:flutter/material.dart';
import 'package:iotchain/controllers/blockchain_adapter.dart';
import 'package:iotchain/model/auth_model.dart';

import '../main.dart';

class AuthPage extends StatefulWidget {
  final Function submitAuth;

  AuthPage({Key key, this.submitAuth}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  AuthCredentials credentials = AuthCredentials();

  @override
  Widget build(BuildContext context) {
    Future<void> submitIdentity() async {
      if (_formKey.currentState.validate()) {
        try {
          if (await Blockchain.authenticate(credentials)) {
            widget.submitAuth();
          }
        }  on Exception catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.teal,
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...[
                        Text("Sign In", style: TextStyle(fontSize: 36),),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter the organization",
                            labelText: "Organization",
                            fillColor: Colors.teal.shade600,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter your organisation";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => credentials.organization = value);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              filled: true,
                              hintText: "Enter a certificate",
                              labelText: "Certificate",
                              fillColor: Colors.teal.shade600),
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
                        TextFormField(
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              filled: true,
                              hintText: "Enter a private key",
                              labelText: "Private key",
                              fillColor: Colors.teal.shade600),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "You must provide private key to identify you";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => credentials.privateKey = value);
                          },
                          maxLines: 5,
                        ),
                        ElevatedButton(
                          onPressed: submitIdentity,
                          child: const Text("Submit identity",
                              style: TextStyle(fontSize: 20)),
                        ),
                      ].expand((widget) => [
                            widget,
                            SizedBox(
                              height: 12,
                            )
                          ])
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
