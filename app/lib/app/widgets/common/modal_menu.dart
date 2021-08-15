import 'package:chainmetric/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_screen/overlay_screen.dart';

class ModalMenuOption extends StatelessWidget {
  final Function()? action;
  final String? title;
  final IconData? icon;
  final bool enabled;

  const ModalMenuOption({
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
              leading: Icon(icon, color: Theme.of(context).primaryColor, size: 30),
              title: Text(title!,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold,
                  color: Theme.of(context).primaryColor
                ),
              )
          )
      )
  );

  void Function() _decorateWithDismiss(BuildContext context, Function? action) => () {
    dismissDialog(context);
    OverlayScreen().pop();
    action!();
  };
}

void showModalMenu({required BuildContext context, required List<ModalMenuOption> options}) {
  OverlayScreen().show(context, identifier: "modal");
  showMaterialModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
    builder: (context) => Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: options.where((o) => o.enabled).toList(),
          ),
        )),
  ).whenComplete(dismissOverlay);
}

void showOverlayPage({
  required BuildContext context,
  required Widget Function(BuildContext) builder
}) {
  OverlayScreen().show(context, identifier: "modal");
  showMaterialModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
    builder: builder,
    expand: true,
    enableDrag: false,
    isDismissible: false
  ).whenComplete(dismissOverlay);
}
