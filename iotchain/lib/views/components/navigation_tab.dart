
import 'package:flutter/cupertino.dart';
import 'bottom_app_bar.dart';

class NavigationTabItem {
  String title;
  CustomAppBarItem navBarItem;
  NavigationTab tab;
  Widget buttonIcon;
  void Function(State) pageAction;

  NavigationTabItem({
    this.title,
    this.navBarItem,
    this.tab,
    this.buttonIcon,
    this.pageAction
  });
}

abstract class NavigationTab extends StatefulWidget {
  const NavigationTab({Key key}) : super(key: key);

  Future refreshData();
}
