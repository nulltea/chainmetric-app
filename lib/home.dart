import 'package:flutter/material.dart';
import 'asset_form.dart';

/// This is the stateful widget that the main application instantiates.
class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) => Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: Center(
          child: Text('List here'),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 50.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AssetForm())
            );
          },
          tooltip: 'Input asset',
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
