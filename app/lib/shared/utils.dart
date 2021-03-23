import 'package:flutter/material.dart';
import 'package:overlay_screen/overlay_screen.dart';

void openPage(BuildContext context, Widget page, {Function() then}) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page)
).whenComplete(() => then?.call());

Future showYesNoDialog(BuildContext context, {
  String title,
  String message,
  Function onYes,
  Function onNo
}) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: _decorateWithDismiss(context, onYes ?? () => print("not implemented")),
          child: Text("Yes"),
        ),
        TextButton(
          onPressed: _decorateWithDismiss(context, onNo ?? () => print("not implemented")),
          child: Text("No"),
        ),
      ],
    ),
  );

void loading(BuildContext context) => OverlayScreen().show(context, identifier: "loading");

Function decorateWithLoading(BuildContext context, Future Function() fn) => () {
  loading(context);
  fn().whenComplete(dismissOverlay);
};

void dismissDialog(BuildContext context) => Navigator.of(context, rootNavigator: true).pop();

Function _decorateWithDismiss(BuildContext context, Function action) => () {
    dismissDialog(context);
    action();
  };

void dismissOverlay() {
  if (OverlayScreen().state == Screen.showing) OverlayScreen().pop();
}

