import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(context) => RefreshIndicator(
    key: _refreshKey,
    onRefresh: _loadData,
    child: Center(child: Text("Profile"),),
  );

  Future<void> _loadData() {
    return null;
  }
}
