import 'package:flutter/material.dart';
import 'package:chainmetric/shared/utils.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_screen/overlay_screen.dart';

class ModalMenuOption extends StatelessWidget {
  final Function() action;
  final String title;
  final IconData icon;
  final bool enabled;

  ModalMenuOption({
    this.title,
    this.icon,
    this.action,
    this.enabled = true
  });

  @override
  Widget build(BuildContext context) => SizedBox(
      width: double.infinity,
      height: 55,
      child: InkWell(
          onTap: _decorateWithDismiss(context, action),
          child: ListTile(
              leading: Icon(icon, color: Colors.teal, size: 30),
              title: Text(title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold,
                    color: Colors.teal
                ),
              )
          )
      )
  );

  Function _decorateWithDismiss(BuildContext context, Function action) => () {
    dismissDialog(context);
    OverlayScreen().pop();
    action();
  };
}

void showModalMenu({BuildContext context, List<ModalMenuOption> options}) {
  OverlayScreen().show(context, identifier: "modal");
  showMaterialModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
    builder: (context) => Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: options.where((o) => o.enabled).toList(),
          ),
        )),
  ).whenComplete(dismissOverlay);
}
