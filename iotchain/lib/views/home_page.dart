import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'asset_form.dart';

import 'components/bottom_app_bar.dart';
import 'components/navigation_tab.dart';
import 'assets_tab.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<NavigationTabItem> tabs = [
    NavigationTabItem(
        navBarItem: CustomAppBarItem(icon: Icons.home),
        tab: Center(child: AssetsTab()),
        buttonIcon: Icon(Icons.qr_code),
        pageAction: (ctx) => AssetForm()
    ),
    NavigationTabItem(
        navBarItem: CustomAppBarItem(icon: Icons.shopping_cart),
        tab: Center(child: AssetsTab()),
        buttonIcon: Icon(Icons.add),
        pageAction: (ctx) => AssetForm()
    ),
    NavigationTabItem(
        navBarItem: CustomAppBarItem(icon: Icons.list),
        tab: Center(child: Text('Requirements')),
        buttonIcon: Icon(Icons.camera),
        pageAction: (ctx) => AssetForm()
    ),
    NavigationTabItem(
        navBarItem: CustomAppBarItem(icon: Icons.person),
        tab: Center(child: Text('Profile')),
        buttonIcon: Icon(Icons.person),
        pageAction: (ctx) => AssetForm()
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
        title: Center(child: Text('IoT Chain')),
      ),
      body: tabs[_currentIndex].tab,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => tabs[_currentIndex].pageAction(context))
          );
        },
        child: tabs[_currentIndex].buttonIcon,
      ),
      bottomNavigationBar: CustomBottomAppBar(
        onTabSelected: _selectedTab,
        items: List.generate(tabs.length, (index) => tabs[index].navBarItem),
      ),
    );
  }
}
