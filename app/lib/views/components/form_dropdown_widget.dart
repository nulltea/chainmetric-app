import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FormDropDownWidget extends StatefulWidget {
  const FormDropDownWidget({
    this.initialOption,
    @required this.items,
    @required this.onChanged,
    this.icon,
    this.width,
    this.height,
    this.fillColor,
    this.textStyle,
    this.elevation,
    this.borderWidth,
    this.borderRadius,
    this.borderColor,
    this.margin,
    this.validator,
  });

  final String initialOption;
  final List<DropdownMenuItem> items;
  final Function(String) onChanged;
  final Function(String) validator;
  final Widget icon;
  final double width;
  final double height;
  final Color fillColor;
  final TextStyle textStyle;
  final double elevation;
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;
  final EdgeInsetsGeometry margin;

  @override
  State<FormDropDownWidget> createState() => _FormDropDownWidgetState();
}

class _FormDropDownWidgetState extends State<FormDropDownWidget> {
  String dropDownValue;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      dropDownValue = widget.initialOption ?? widget.items.first.value;
      widget.onChanged(dropDownValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 28),
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
        ),
        color: widget.fillColor ?? Theme.of(context).inputDecorationTheme.fillColor,
      ),
      child: Padding(
        padding: widget.margin,
        child: Container(
          width: widget.width,
          height: widget.height,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: dropDownValue,
                items: widget.items,
                elevation: widget.elevation.toInt(),
                onChanged: (value) {
                  final error = widget.validator(value);
                  if (error == null) {
                    dropDownValue = value;
                    widget.onChanged(value);
                  }
                },
                icon: widget.icon,
                isExpanded: true,
                dropdownColor: widget.fillColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}