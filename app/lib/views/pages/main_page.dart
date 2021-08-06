import 'package:chainmetric/main_theme.dart';
import 'package:chainmetric/shared/utils.dart';
import 'package:flutter/material.dart';

import 'package:chainmetric/views/components/bottom_app_bar.dart';
import 'package:chainmetric/views/components/navigation_tab.dart';
import 'package:chainmetric/views/pages/assets/asset_form.dart';
import 'package:chainmetric/views/pages/assets/assets_tab.dart';
import 'package:chainmetric/views/pages/devices/device_form.dart';
import 'package:chainmetric/views/pages/devices/devices_tab.dart';
import 'package:chainmetric/views/pages/home/home_tab.dart';
import 'package:chainmetric/views/pages/organization/profile_tab.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  List<NavigationTabItem> tabs = [
    NavigationTabItem(
        title: "IoT Chain",
        navBarItem: CustomAppBarItem(icon: Icons.home_filled),
        tab: HomeTab(),
        buttonIcon: const Icon(Icons.cached, color: Colors.black),
        pageAction: (ctx) => print("Home")),
    NavigationTabItem(
        title: "Assets",
        navBarItem: CustomAppBarItem(icon: Icons.shopping_cart_sharp),
        tab: AssetsTab(key: GlobalKey()),
        buttonIcon: const Icon(Icons.add, color: Colors.black),
        pageAction: (state) => openPage(state.context, const AssetForm(),
            then: (state as _MainPageState).currentTab().refreshData)),
    NavigationTabItem(
        title: "Devices",
        navBarItem: CustomAppBarItem(icon: Icons.memory_sharp),
        tab: DevicesTab(key: GlobalKey()),
        buttonIcon: const Icon(Icons.qr_code_scanner, color: Colors.black),
        pageAction: (state) => openPage(state.context, const DeviceForm(),
            then: (state as _MainPageState).currentTab().refreshData)),
    NavigationTabItem(
        title: "Profile",
        navBarItem: CustomAppBarItem(icon: Icons.people_alt_sharp),
        tab: ProfileTab(),
        buttonIcon: const Icon(Icons.person, color: Colors.black),
        pageAction: (ctx) => print("Profile")),
  ];

  void selectedTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  NavigationTab currentTab() => tabs[_currentIndex].tab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex].tab,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => tabs[_currentIndex].pageAction(this),
        child: tabs[_currentIndex].buttonIcon,
      ),
      bottomNavigationBar: CustomBottomAppBar(
        onTabSelected: selectedTab,
        items: List.generate(tabs.length, (index) => tabs[index].navBarItem),
      ),
    );
  }
}
