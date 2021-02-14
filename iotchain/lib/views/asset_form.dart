import 'dart:io';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';
import 'package:iotchain/model/organization_model.dart';

import '../model/asset_model.dart';

class AssetForm extends StatefulWidget {
  @override
  _AssetFormState createState() => _AssetFormState();
}

class _AssetFormState extends State<AssetForm> {
  Asset asset;
  final List<Organization> organizations = JsonMapper.deserialize(File("assets/data/organizations.json").readAsStringSync());
  final List<AssetType> assetTypes = JsonMapper.deserialize(File("assets/data/asset_types.json").readAsStringSync());
  final _formKey = GlobalKey<FormState>();

  Future<void> submitAsset() async {}

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
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...[
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter an asset name",
                            labelText: "Name",
                          ),
                          onChanged: (value) {
                            setState(() => asset.name = value);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter an SKU code",
                            labelText: "SKU code",
                          ),
                          onChanged: (value) {
                            setState(() => asset.name = value);
                          },
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Choose asset type",
                            labelText: "Asset type",
                            fillColor: Colors.teal.shade600,
                          ),
                          items: assetTypes.map<DropdownMenuItem<String>>(
                                  (org) => DropdownMenuItem<String>(
                                value: org.type,
                                child: Text(org.name),
                              ))
                              .toList(),
                          onChanged: (value) {
                            setState(() => asset.owner = value);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            filled: true,
                            hintText: "Enter asset description",
                            labelText: "Description",
                          ),
                          onChanged: (value) {
                            setState(() => asset.info = value);
                          },
                          maxLines: 5,
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Choose the owner organization",
                            labelText: "Owned by",
                            fillColor: Colors.teal.shade600,
                          ),
                          items: organizations.map<DropdownMenuItem<String>>(
                                  (org) => DropdownMenuItem<String>(
                                value: org.mspID,
                                child: Text(org.name),
                              ))
                              .toList(),
                          onChanged: (value) {
                            setState(() => asset.owner = value);
                          },
                        ),
                        ElevatedButton(
                          onPressed: submitAsset,
                          child: const Text("Submit asset",
                              style: TextStyle(fontSize: 20)),
                        ),
                      ].expand((widget) => [
                            widget,
                            SizedBox(
                              height: 24,
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
