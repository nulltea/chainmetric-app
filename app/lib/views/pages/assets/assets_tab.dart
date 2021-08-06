import 'package:chainmetric/controllers/assets_controller.dart';
import 'package:chainmetric/controllers/references_adapter.dart';
import 'package:chainmetric/controllers/requirements_controller.dart';
import 'package:chainmetric/main_theme.dart';
import 'package:chainmetric/models/asset_model.dart';
import 'package:chainmetric/shared/utils.dart';
import 'package:chainmetric/views/components/modal_menu.dart';
import 'package:chainmetric/views/components/navigation_tab.dart';
import 'package:chainmetric/views/pages/readings/readings_page.dart';
import 'package:chainmetric/views/pages/requirements/requirements_form.dart';
import 'package:chainmetric/views/pages/assets/asset_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AssetsTab extends NavigationTab {
  AssetsTab({GlobalKey key}) : super(key: key ?? GlobalKey());

  _AssetsTabState get _currentState =>
      (key as GlobalKey)?.currentState as _AssetsTabState;

  @override
  _AssetsTabState createState() => _AssetsTabState();

  @override
  Future refreshData() => _currentState._refreshData();
}

class _AssetsTabState extends State<AssetsTab> {
  List<AssetResponseItem> assets = [];
  String scrollID;

  static const _itemsLength = 50;
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Assets",
          style: AppTheme.title2.override(fontSize: 28)),
      centerTitle: false,
      automaticallyImplyLeading: false,
      elevation: 4,
    ),
    body: RefreshIndicator(
          key: _refreshKey,
          onRefresh: _refreshData,
          child: ListView.builder(
            itemCount: assets.length,
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemBuilder: _listBuilder,
          ),
        ),
  );

  /*
  TextFormField(
                onChanged: (_) => setState(() {}),
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search for assets...",
                  hintStyle: AppTheme.bodyText1.override(
                    fontFamily: "Roboto Mono",
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.appBarBG,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.zero,
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.appBarBG,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.zero,
                  ),
                  prefixIcon: const Icon(Icons.search_sharp),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? InkWell(
                          onTap: () => setState(
                            () => _searchController.clear(),
                          ),
                          child: const Icon(
                            Icons.clear,
                            size: 22,
                          ),
                        )
                      : null,
                ),
                style: AppTheme.bodyText1.override(
                  fontFamily: "Roboto Mono",
                ),
              )
   */

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
        tag: assets[index].id,
        child: _assetCard(assets[index]),
      ),
    );
  }

  Widget _assetCard(AssetResponseItem asset) => InkWell(
        onLongPress: () => _showAssetMenu(context, asset),
        child: Card(
          elevation: 5,
          color: References.assetTypesMap[asset.type].color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Icon(Icons.photo, size: 90),
              const SizedBox(width: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height: 8),
                Text(asset.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                Text(asset.sku,
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.w400))
              ]),
              const Spacer(),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.corporate_fare,
                        color: Theme.of(context).hintColor),
                    const SizedBox(width: 5),
                    Text(References.organizationsMap[asset.holder].name,
                        style: TextStyle(color: Theme.of(context).hintColor))
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Theme.of(context).hintColor),
                    const SizedBox(width: 5),
                    Text(asset.location.name,
                        style: TextStyle(color: Theme.of(context).hintColor))
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.fact_check, color: Theme.of(context).hintColor),
                    const SizedBox(width: 5),
                    Text(
                        asset.requirements != null
                            ? "Assigned (${asset.requirements.metrics.length})"
                            : "Not assigned",
                        style: TextStyle(color: Theme.of(context).hintColor))
                  ],
                )
              ]),
            ]),
          ),
        ),
      );

  Future<AssetsResponse> _fetchAssets() async =>
      AssetsController.getAssets(limit: _itemsLength, scrollID: scrollID);

  void _showAssetMenu(BuildContext context, AssetResponseItem asset) {
    showModalMenu(context: context, options: [
      ModalMenuOption(
        title: asset.requirements == null
            ? "Assign requirements"
            : "Edit requirements",
        icon: Icons.fact_check,
        action: () => openPage(
            context, RequirementsForm(model: asset.getRequirements()),
            then: _refreshData),
      ),
      ModalMenuOption(
        title: "Revoke requirements",
        icon: Icons.delete_sweep,
        action: decorateWithLoading(
            context,
            () =>
                RequirementsController.revokeRequirements(asset.requirements.id)
                    .whenComplete(_refreshData)),
        enabled: asset.requirements != null,
      ),
      ModalMenuOption(
          title: "Transfer asset",
          icon: Icons.local_shipping,
          action: () => print("Transfer asset")),
      ModalMenuOption(
          title: "History",
          icon: Icons.history,
          action: () => print("View history")),
      ModalMenuOption(
          title: "Watch asset",
          icon: Icons.visibility,
          action: () => openPage(context,
              ReadingsPage(asset: asset, requirements: asset.requirements))),
      ModalMenuOption(
          title: "Edit asset",
          icon: Icons.edit,
          action: () =>
              openPage(context, AssetForm(model: asset), then: _refreshData)),
      ModalMenuOption(
          title: "Delete asset",
          icon: Icons.delete_forever,
          action: () => showYesNoDialog(context,
              title: "Delete ${asset.sku}",
              message: "Are you sure?",
              onYes: decorateWithLoading(
                  context,
                  () => AssetsController.deleteAsset(asset.id)
                      .whenComplete(_refreshData)),
              onNo: () => print("close modal"))),
    ]);
  }
}
