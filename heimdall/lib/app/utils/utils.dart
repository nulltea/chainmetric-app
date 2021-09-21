import 'package:chainmetric/app/pages/identity/login_page.dart';
import 'package:chainmetric/app/theme/theme.dart';
import 'package:chainmetric/app/widgets/common/modal_menu.dart';
import 'package:chainmetric/platform/repositories/identities_shared.dart';
import 'package:chainmetric/usecase/identity/identity_manager.dart';
import 'package:flutter/material.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:chainmetric/models/identity/user.dart';

void openPage(BuildContext context, Widget page,
        {Function()? then, int duration = 300}) =>
    Navigator.push(
            context,
            CustomMaterialPageRoute(
                builder: (context) => page, duration: duration))
        .whenComplete(() => then?.call());

Future showYesNoDialog(BuildContext context,
        {String? title, String? message, Function? onYes, Function? onNo}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title!),
        content: Text(message!),
        actions: <Widget>[
          TextButton(
            onPressed: _decorateWithDismiss(
                context, onYes ?? () => print("not implemented")),
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: _decorateWithDismiss(
                context, onNo ?? () => print("not implemented")),
            child: const Text("No"),
          ),
        ],
      ),
    );

void loading(BuildContext context) =>
    OverlayScreen().show(context, identifier: "loading");

/// Wraps function `fn` in loading and returns function,
/// so it's must be used without () => when passing as functor.
void Function() decorateWithLoading(
        BuildContext context, Future Function() fn) =>
    () {
      loading(context);
      fn().whenComplete(dismissOverlay);
    };

void dismissDialog(BuildContext context) =>
    Navigator.of(context, rootNavigator: true).pop();

void Function() _decorateWithDismiss(BuildContext context, Function action) =>
    () {
      dismissDialog(context);
      action();
    };

void dismissOverlay() {
  try {
    if (OverlayScreen().state == Screen.showing) OverlayScreen().pop();
  } on Exception {}
}

class CustomMaterialPageRoute<T> extends MaterialPageRoute<T> {
  final int duration;

  CustomMaterialPageRoute(
      {required WidgetBuilder builder,
      RouteSettings? settings,
      bool fullscreenDialog = false,
      this.duration = 300})
      : super(
            builder: builder,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  Duration get transitionDuration => Duration(milliseconds: duration);
}

void displayError(BuildContext context, Exception e) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        elevation: 6.0,
        backgroundColor: AppTheme.error,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)))));