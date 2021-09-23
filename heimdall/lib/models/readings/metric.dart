import 'package:chainmetric/app/widgets/common/svg_icon.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:flutter/material.dart';

part "metric.g.dart";

@JsonSerializable()
class Metric {
  late final String name;
  late final String metric;
  late final String unit;
  @JsonKey(name: "icon")
  String? iconName;
  @JsonKey(name: "icon_type")
  String? iconType;

  Metric();

  Widget icon(
          {double size = 24,
          Color? color,
          Widget fallback = const SvgIcon("sensors")}) =>
      iconName != null
          ? iconType == "svg"
              ? SvgIcon(iconName, size: size, color: color)
              : Text(iconName!,
                  style: TextStyle(
                      fontFamily: iconType ?? "MaterialIcons",
                      fontSize: size,
                      color: color))
          : fallback;

  factory Metric.fromJson(Map<String, dynamic> json) => _$MetricFromJson(json);

  Map<String, dynamic> toJson() => _$MetricToJson(this);

  static List<Metric> listFromJson(List<dynamic> json) =>
      json.map((e) => Metric.fromJson(e)).toList();
}
