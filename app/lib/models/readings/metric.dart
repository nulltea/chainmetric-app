import 'package:chainmetric/app/widgets/common/svg_icon.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';

@jsonSerializable
class Metric {
  String? name;
  String? metric;
  String? unit;
  @JsonProperty(name: "icon")
  String? iconRaw;

  Widget icon({
    double size = 24,
    Color? color,
    Widget fallback = const SvgIcon("sensors")
  }) => iconRaw?.isNotEmpty ?? false
      ? _iconPoint != null && _iconPoint != 0
          ? Icon(IconData(_iconPoint!, fontFamily: "MaterialIcons"),
                  size: size,
                  color: color,
                )
          : SvgIcon(iconRaw, size: size, color: color)
      : fallback;

  int? get _iconPoint => iconRaw != null
      ? int.tryParse(iconRaw!)
      : 0;
}
