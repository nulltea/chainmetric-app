import 'package:flutter/material.dart';

class CustomAppBarItem {
  IconData icon;
  CustomAppBarItem({this.icon});
}

class CustomBottomAppBar extends StatefulWidget {
  final ValueChanged<int> onTabSelected;
  final List<CustomAppBarItem> items;

  CustomBottomAppBar({this.onTabSelected, this.items}) {
    assert(items.length == 2 || items.length == 4);
  }

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int _selectedIndex = 0;

  void _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = List.generate(widget.items.length, (int index) {
      return _buildTabIcon(
          index: index, item: widget.items[index], onPressed: _updateIndex);
    });

    items.insert(items.length >> 1, _buildMiddleSeparator());

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _buildMiddleSeparator() {
    return Expanded(
      child: SizedBox(
        height: 60.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
             SizedBox(
              height: 24.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabIcon(
      {int index, CustomAppBarItem item, ValueChanged<int> onPressed}) {
    return Expanded(
      child: SizedBox(
        height: 60.0,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Icon(
                    item.icon,
                    color: _selectedIndex == index ? Theme.of(context).primaryColor: Colors.grey,
                    size: 24.0,
                  ),
          ),
        ),
      ),
    );
  }
}
