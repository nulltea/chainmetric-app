import 'package:chainmetric/controllers/assets_controller.dart';
import 'package:chainmetric/main_theme.dart';
import 'package:chainmetric/models/asset_model.dart';
import 'package:chainmetric/views/components/assets/card.dart';
import 'package:chainmetric/views/components/assets/search_delegate.dart';
import 'package:chainmetric/views/components/common/navigation_tab.dart';
import 'package:flutter/cupertino.dart';
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
  List<AssetPresenter> assets = [];
  String scrollID;

  static const _itemsLength = 50;
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text("Assets",
              style: AppTheme.title2.override(fontFamily: "IBM Plex Mono", fontSize: 28)),
          centerTitle: false,
          elevation: 4,
          actionsIconTheme: Theme.of(context).iconTheme,
          actions: [
            IconButton(
                onPressed: () => showSearch<int>(
                    context: context,
                    delegate: AssetsSearchDelegate(),
                  ), icon: const Icon(Icons.search_sharp))
          ],
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

  Future<void> _refreshData() {
    _refreshKey.currentState?.show();
    return AssetsController.getAssets(limit: _itemsLength, scrollID: scrollID).then((value) =>
        setState(() {
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
        child: AssetCard(assets[index], refreshParent: _refreshData),
      ),
    );
  }
}