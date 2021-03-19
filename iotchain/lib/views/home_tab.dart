import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() {
    return null;
  }

  @override
  Widget build(context) => RefreshIndicator(
    key: _refreshKey,
    onRefresh: _loadData,
    child: Center(child: Text("Home"),),
  );
}
