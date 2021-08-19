import 'package:chainmetric/app/widgets/common/svg_icon.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:flutter/material.dart';

part "metric.g.dart";

@JsonSerializable()
class Metric {
  String? name;
  String? metric;
  String? unit;
  @JsonKey(name: "icon")
  String? iconRaw;

  Metric();

  Widget icon(
          {double size = 24,
          Color? color,
          Widget fallback = const SvgIcon("sensors")}) =>
      iconRaw?.isNotEmpty ?? false
          ? _iconPoint != null && _iconPoint != 0
              ? Icon(
                  IconData(_iconPoint!, fontFamily: "MaterialIcons"),
                  size: size,
                  color: color,
                )
              : SvgIcon(iconRaw, size: size, color: color)
          : fallback;

  int? get _iconPoint => iconRaw != null ? int.tryParse(iconRaw!) : 0;

  factory Metric.fromJson(Map<String, dynamic> json) => _$MetricFromJson(json);
  Map<String, dynamic> toJson() => _$MetricToJson(this);
}
