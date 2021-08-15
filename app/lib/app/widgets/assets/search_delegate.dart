
import 'package:chainmetric/infrastructure/repositories/assets_fabric.dart';
import 'package:chainmetric/models/assets/asset.dart';
import 'package:chainmetric/app/widgets/assets/card.dart';
import 'package:chainmetric/app/widgets/common/loading_splash.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class AssetsSearchDelegate extends SearchDelegate<int> {
  static const _itemsLength = 20;

  AssetsSearchDelegate();

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isEmpty) IconButton(
        tooltip: "Voice Search",
        icon: const Icon(Icons.mic),
        onPressed: () { },
      ) else IconButton(
        tooltip: "Clear",
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        tooltip: "Back",
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        }
    );

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  @override
  Widget buildResults(BuildContext context) => FutureBuilder<AssetsResponse?>(
      future: AssetsController.getAssets(query: AssetsQuery()..limit = _itemsLength),
      builder: (context, snapshot) => snapshot.data != null
          ? ListView.builder(
              itemCount: snapshot.data!.items.length,
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemBuilder: _listBuilder(snapshot.data!.items) as Widget Function(BuildContext, int))
          : Container(),
    );


  Function(BuildContext context, int index) _listBuilder(List<AssetPresenter> assets) {
    return (context, index) => Hero(
      tag: assets[index].id!,
      child: AssetCard(assets[index]),
    );
  }
}