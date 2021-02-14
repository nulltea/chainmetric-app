import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:iotchain/controllers/blockchain_adapter.dart';
import 'package:iotchain/model/organization_model.dart';
import 'package:iotchain/model/asset_model.dart';

class AssetForm extends StatefulWidget {
  @override
  _AssetFormState createState() => _AssetFormState();
}

class _AssetFormState extends State<AssetForm> {
  Asset asset = Asset();
  List<Organization> organizations = <Organization>[];
  List<AssetType> assetTypes = <AssetType>[];

  final _formKey = GlobalKey<FormState>();

  Future<void> submitAsset() async {
    if (_formKey.currentState.validate()) {
      try {
        var jsonData = JsonMapper.serialize(asset);
        await Blockchain.submitTransaction("assets", "Insert", jsonData);
        Navigator.pop(context);
      } on Exception catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  void initState() {
    rootBundle.loadString("assets/data/organizations.json").then((value) =>
        setState(() => organizations = JsonMapper.deserialize<List<Organization>>(value)));
    rootBundle.loadString("assets/data/asset_types.json").then((value) =>
        setState(() => assetTypes = JsonMapper.deserialize<List<AssetType>>(value)));
    super.initState();
  }

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
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please provide name for new asset";
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please provide SKU code for new asset";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => asset.sku = value);
                          },
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Choose asset type",
                            labelText: "Asset type",
                          ),
                          items: assetTypes
                              .map<DropdownMenuItem<String>>(
                                  (org) => DropdownMenuItem<String>(
                                        value: org.type,
                                        child: Text(org.name),
                                      ))
                              .toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please choose an asset type";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => asset.type = value);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter an cost",
                            labelText: "Cost",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please provide cost for new asset";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() => asset.cost = double.parse(value));
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter asset description",
                            labelText: "Description",
                            filled: true,
                          ),
                          onChanged: (value) {
                            setState(() => asset.info = value);
                          },
                          maxLines: 5,
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: "Choose the owner organization",
                            labelText: "Owned by",
                            filled: true,
                          ),
                          items: organizations
                              .map<DropdownMenuItem<String>>(
                                  (org) => DropdownMenuItem<String>(
                                        value: org.mspID,
                                        child: Text(org.name),
                                      ))
                              .toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please choose an owner organization";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => asset.owner = value);
                          },
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                          onPressed: submitAsset,
                          child: const Text("Submit asset",
                              style: TextStyle(fontSize: 20)),
                        )),
                      ].expand((widget) => [
                            widget,
                            SizedBox(height: 24,)
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
