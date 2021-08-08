import 'package:chainmetric/main_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../components/navigation_tab.dart';

class ProfileTab extends NavigationTab {
  ProfileTab({GlobalKey key}) : super(key: key ?? GlobalKey());

  _ProfileTabState get _currentState =>
      (key as GlobalKey)?.currentState as _ProfileTabState;

  @override
  _ProfileTabState createState() => _ProfileTabState();

  @override
  Future refreshData() => _currentState._refreshData();
}

class _ProfileTabState extends State<ProfileTab> {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Your organization",
          style: AppTheme.title2.override(fontFamily: "IBM Plex Mono", fontSize: 28)),
      centerTitle: false,
      automaticallyImplyLeading: false,
      elevation: 4,
    ),
    body: RefreshIndicator(
      key: _refreshKey,
      onRefresh: _refreshData,
      child: const Center(child: Text("Profile here"),),
    ),
  );

  Future _refreshData() {
    return null;
  }
}
