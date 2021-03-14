import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iotchain/controllers/blockchain_adapter.dart';
import 'package:iotchain/controllers/references_adapter.dart';
import 'package:iotchain/model/asset_model.dart';
import 'package:iotchain/views/requirements_form.dart';

class AssetsTab extends StatefulWidget {
  const AssetsTab({Key key}) : super(key: key);

  @override
  _AssetsTabState createState() => _AssetsTabState();
}

class _AssetsTabState extends State<AssetsTab> {
  static const _itemsLength = 50;
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  List<Asset> assets = [];

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() {
    return fetchAssets().then((value) => setState(() => assets = value));
  }

  Widget _listBuilder(BuildContext context, int index) {
    if (index >= _itemsLength) return null;
    return SafeArea(
      top: false,
      bottom: false,
      child: Hero(
        tag: index,
        child: GestureDetector(
          child: _assetCard(assets[index]),
          onLongPress: () => showMenu(
            items: <PopupMenuEntry>[
              PopupMenuItem<Function>(
                value: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RequirementsForm())
                ),
                child: Text("Assign requirements"),
              ),
            ],
            context: context,
            position: RelativeRect.fromLTRB(100, 100, 100, 100),
           ).then((action) => action()),
        ),
      ),
    );
  }

  Widget _assetCard(Asset asset) => Card(
        elevation: 5,
        color: References.assetTypesMap[asset.type].color,
        child: Container(
          height: 100,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    children: <Widget>[
                      Text(asset.name,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text("${asset.cost}\$"),
                      Spacer(),
                      Text(References.organizationsMap[asset.holder].name),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  )),
            ),
          ),
        ),
      );

  @override
  Widget build(context) => RefreshIndicator(
        key: _refreshKey,
        onRefresh: _refreshData,
        child: ListView.builder(
          itemCount: assets.length,
          padding: EdgeInsets.symmetric(vertical: 12),
          itemBuilder: _listBuilder,
        ),
      );

  Future<List<Asset>> fetchAssets() async {
    String data = await Blockchain.evaluateTransaction("assets", "List");
    try {
      return data.isNotEmpty ? JsonMapper.deserialize<List<Asset>>(data) : <Asset>[];
    } on Exception catch (e) {
      print(e.toString());
    }
    return <Asset>[];
  }
}
