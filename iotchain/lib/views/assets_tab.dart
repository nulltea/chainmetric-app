import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iotchain/controllers/assets_controller.dart';
import 'package:iotchain/controllers/blockchain_adapter.dart';
import 'package:iotchain/controllers/references_adapter.dart';
import 'package:iotchain/model/asset_model.dart';
import 'package:iotchain/shared/utils.dart';
import 'package:iotchain/shared/extensions.dart';
import 'package:iotchain/views/asset_form.dart';
import 'package:iotchain/views/components/modal_menu.dart';
import 'package:iotchain/views/requirements_form.dart';


class AssetsTab extends StatefulWidget {
  const AssetsTab({Key key}) : super(key: key);

  @override
  _AssetsTabState createState() => _AssetsTabState();
}

class _AssetsTabState extends State<AssetsTab> {
  List<AssetResponseItem> assets = [];
  String scrollID;

  static const _itemsLength = 50;
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

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

  Future<void> _refreshData() {
    _refreshKey.currentState?.show();
    return _fetchAssets().then((value) => setState(() {
          assets = value.items;
          scrollID = value.scrollID;
        }));
  }

  Widget _listBuilder(BuildContext context, int index) {
    if (index >= _itemsLength) return null;
    return SafeArea(
      top: false,
      bottom: false,
      child: Hero(
        tag: index,
        child: _assetCard(assets[index]),
      ),
    );
  }

  Widget _assetCard(AssetResponseItem asset) => InkWell(
        child: Card(
          elevation: 5,
          color: References.assetTypesMap[asset.type].color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.photo, size: 90),
              SizedBox(width: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 8),
                Text(asset.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                Text(asset.sku,
                    style: TextStyle(
                        fontSize: 15, color: Theme.of(context).hintColor, fontWeight: FontWeight.w400))
              ]),
              Spacer(),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.corporate_fare,
                        color: Theme.of(context).hintColor),
                    SizedBox(width: 5),
                    Text(References.organizationsMap[asset.holder].name,
                        style:
                            TextStyle(color: Theme.of(context).hintColor))
                  ],
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on,
                        color: Theme.of(context).hintColor),
                    SizedBox(width: 5),
                    Text(asset.location.toSentenceCase,
                        style:
                        TextStyle(color: Theme.of(context).hintColor))
                  ],
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.fact_check,
                        color: Theme.of(context).hintColor),
                    SizedBox(width: 5),
                    Text(asset.requirements != null
                        ? "Assigned (${asset.requirements.metrics.length})"
                        : "Not assigned",
                        style:
                        TextStyle(color: Theme.of(context).hintColor))
                  ],
                )
              ]),
            ]),
          ),
        ),
        onLongPress: () => _showAssetMenu(context, asset),
      );

  Future<AssetsResponse> _fetchAssets() async {
    var query = AssetQuery(limit: _itemsLength, scrollID: scrollID);
    String data = await Blockchain.evaluateTransaction(
        "assets", "Query", JsonMapper.serialize(query));
    try {
      return data.isNotEmpty
          ? JsonMapper.deserialize<AssetsResponse>(data)
          : AssetsResponse();
    } on Exception catch (e) {
      print(e.toString());
    }
    return AssetsResponse();
  }

  void _showAssetMenu(BuildContext context, AssetResponseItem asset) {
    showModalMenu(context: context, options: [
      ModalMenuOption(
          title: asset.requirements == null
              ? "Assign requirements"
              : "Edit requirements",
          icon: Icons.fact_check,
          action: () => openPage(
              context, RequirementsForm(model: asset.getRequirements()))
      ),
      ModalMenuOption(
          title: "Transfer asset",
          icon: Icons.local_shipping,
          action: () => print("Transfer asset")
      ),
      ModalMenuOption(
          title: "History",
          icon: Icons.history,
          action: () => print("View history")
      ),
      ModalMenuOption(
          title: "Watch asset",
          icon: Icons.visibility,
          action: () => print("Watch asset")
      ),
      ModalMenuOption(
          title: "Edit asset",
          icon: Icons.edit,
          action: () => openPage(context, AssetForm(model: asset))
      ),
      ModalMenuOption(
          title: "Delete asset",
          icon: Icons.delete_forever,
          action: () => showYesNoDialog(context,
              title: "Delete ${asset.sku}",
              message: "Are you sure?",
              onYes: () => AssetsController.deleteAsset(asset.id),
              onNo: () => print("close modal"))
      ),
    ]);
  }
}
