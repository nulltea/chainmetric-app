import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  final String? icon;
  final Color? color;
  final double size;

  const SvgIcon(
    this.icon, {
    this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) => icon != null
      ? SvgPicture.asset(
          "assets/icons/$icon.svg",
          color: color ?? Theme.of(context).iconTheme.color,
          width: size,
        )
      : Icon(Icons.help);
}
