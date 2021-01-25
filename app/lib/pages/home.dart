import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'asset_form.dart';
import '../components/bottom_app_bar.dart';
import '../components/navigation_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<NavigationTabItem> tabs = [
    NavigationTabItem(
        navBarItem: CustomAppBarItem(icon: Icons.home),
        tab: Center(child: Text('Home')),
        buttonIcon: Icon(Icons.qr_code)
    ),
    NavigationTabItem(
        navBarItem: CustomAppBarItem(icon: Icons.shopping_cart),
        tab: Center(child: Text('Assets')),
        buttonIcon: Icon(Icons.add)
    ),
    NavigationTabItem(
        navBarItem: CustomAppBarItem(icon: Icons.list),
        tab: Center(child: Text('Requirements')),
        buttonIcon: Icon(Icons.camera)
    ),
    NavigationTabItem(
        navBarItem: CustomAppBarItem(icon: Icons.person),
        tab: Center(child: Text('Profile')),
        buttonIcon: Icon(Icons.add)
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
        title: Center(child: Text('IoT Blockchain')),
      ),
      body: tabs[_currentIndex].tab,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AssetForm())
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
