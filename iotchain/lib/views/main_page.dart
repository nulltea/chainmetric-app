import 'package:flutter/material.dart';
import 'package:iotchain/shared/utils.dart';
import 'package:iotchain/views/devices_tab.dart';
import 'package:iotchain/views/home_tab.dart';
import 'package:iotchain/views/profile_tab.dart';
import 'asset_form.dart';

import 'components/bottom_app_bar.dart';
import 'components/navigation_tab.dart';
import 'assets_tab.dart';
import 'device_form.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  List<NavigationTabItem> tabs = [
    NavigationTabItem(
        title: "IoT Chain",
        navBarItem: CustomAppBarItem(icon: Icons.home),
        tab: Center(child: HomeTab()),
        buttonIcon: Icon(Icons.cached),
        pageAction: (ctx) => print("Home")
    ),
    NavigationTabItem(
        title: "Assets",
        navBarItem: CustomAppBarItem(icon: Icons.shopping_cart),
        tab: Center(child: AssetsTab()),
        buttonIcon: Icon(Icons.add),
        pageAction: (ctx) => openPage(ctx, AssetForm())
    ),
    NavigationTabItem(
        title: "Devices",
        navBarItem: CustomAppBarItem(icon: Icons.memory),
        tab: Center(child: DevicesTab()),
        buttonIcon: Icon(Icons.qr_code_scanner),
        pageAction: (ctx) => openPage(ctx, DeviceForm())
    ),
    NavigationTabItem(
        title: "Profile",
        navBarItem: CustomAppBarItem(icon: Icons.person),
        tab: Center(child: ProfileTab()),
        buttonIcon: Icon(Icons.person),
        pageAction: (ctx) => openPage(ctx, AssetForm())
    ),
  ];

  void _selectedTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(tabs[_currentIndex].title)),
      ),
      body: tabs[_currentIndex].tab,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => tabs[_currentIndex].pageAction(context),
        child: tabs[_currentIndex].buttonIcon,
      ),
      bottomNavigationBar: CustomBottomAppBar(
        onTabSelected: _selectedTab,
        items: List.generate(tabs.length, (index) => tabs[index].navBarItem),
      ),
    );
  }


}
