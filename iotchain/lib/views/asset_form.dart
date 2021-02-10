import 'package:flutter/material.dart';

import '../model/asset_model.dart';

class AssetForm extends StatefulWidget {
  @override
  _AssetFormState createState() => _AssetFormState();
}

class _AssetFormState extends State<AssetForm> {
  final _formKey = GlobalKey<FormState>();
  Asset asset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Asset"),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Enter a title...',
                            labelText: 'Title',
                          ),
                          onChanged: (value) {
                            setState(() => asset.name = value);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            filled: true,
                            hintText: 'Enter a description...',
                            labelText: 'Description',
                          ),
                          onChanged: (value) {
                            setState(() => asset.description = value);
                          },
                          maxLines: 5,
                        ),
                      ]
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}