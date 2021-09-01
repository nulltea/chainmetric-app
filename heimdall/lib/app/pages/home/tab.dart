import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/app/widgets/common/navigation_tab.dart';
import 'package:flutter/material.dart';

class HomeTab extends NavigationTab {
  const HomeTab({GlobalKey? key}) : super(key: key);

  _HomeTabState? get _currentState =>
      (key as GlobalKey?)?.currentState as _HomeTabState?;

  @override
  _HomeTabState createState() => _HomeTabState();

  @override
  Future? refreshData() => _currentState!._loadData();
}

class _HomeTabState extends State<HomeTab> {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Chainmetric",
              style: AppTheme.title2
                  .override(fontFamily: "IBM Plex Mono", fontSize: 28)),
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 4,
        ),
        body: RefreshIndicator(
          key: _refreshKey,
          onRefresh: _loadData,
          child: const Center(
            child: Text("Home dashboard here"),
          ),
        ),
      );

  Future<void> _loadData() {
    return Future.value();
  }
}
