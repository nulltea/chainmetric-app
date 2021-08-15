import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FormButtonOptions {
  const FormButtonOptions({
    this.textStyle,
    this.elevation,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.disabledColor,
    this.disabledTextColor,
    this.splashColor,
    this.iconPadding,
    this.borderRadius,
    this.borderSide,
  });

  final TextStyle? textStyle;
  final double? elevation;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final Color? splashColor;
  final EdgeInsetsGeometry? iconPadding;
  final double? borderRadius;
  final BorderSide? borderSide;
}

class FormButtonWidget extends StatelessWidget {
  const FormButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.options,
    this.icon,
  }) : super(key: key);

  final String text;
  final Widget? icon;
  final VoidCallback onPressed;
  final FormButtonOptions options;

  @override
  Widget build(BuildContext context) {
    Widget textWidget = AutoSizeText(
      text,
      style: options.textStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
    if (icon != null) {
      textWidget = Flexible(child: textWidget);
      return Container(
        height: options.height,
        width: options.width,
        child: RaisedButton.icon(
          icon: Padding(
            padding: options.iconPadding ?? EdgeInsets.zero,
            child: icon,
          ),
          label: textWidget,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(options.borderRadius!),
            side: options.borderSide ?? BorderSide.none,
          ),
          color: options.color,
          colorBrightness: ThemeData.estimateBrightnessForColor(options.color!),
          textColor: options.textStyle!.color,
          disabledColor: options.disabledColor,
          disabledTextColor: options.disabledTextColor,
          elevation: options.elevation,
          splashColor: options.splashColor,
        ),
      );
    }

    return Container(
      height: options.height,
      width: options.width,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(options.borderRadius ?? 28),
          side: options.borderSide ?? BorderSide.none,
        ),
        textColor: options.textStyle!.color,
        color: options.color,
        colorBrightness: ThemeData.estimateBrightnessForColor(options.color!),
        disabledColor: options.disabledColor,
        disabledTextColor: options.disabledTextColor,
        padding: options.padding,
        elevation: options.elevation,
        child: textWidget,
      ),
    );
  }
}