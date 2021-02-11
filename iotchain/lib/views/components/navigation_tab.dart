
import 'package:flutter/cupertino.dart';
import 'bottom_app_bar.dart';

class NavigationTabItem {
  CustomAppBarItem navBarItem;
  Widget tab;
  Icon buttonIcon;
  Widget Function(BuildContext) pageAction;

  NavigationTabItem({this.navBarItem, this.tab, this.buttonIcon, this.pageAction});
}