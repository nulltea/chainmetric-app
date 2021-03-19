
import 'package:flutter/cupertino.dart';
import 'bottom_app_bar.dart';

class NavigationTabItem {
  String title;
  CustomAppBarItem navBarItem;
  Widget tab;
  Icon buttonIcon;
  void Function(BuildContext) pageAction;

  NavigationTabItem({
    this.title,
    this.navBarItem,
    this.tab,
    this.buttonIcon,
    this.pageAction
  });
}