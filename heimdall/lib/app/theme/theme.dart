import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF04AFD3);
  static const Color secondaryColor = Color(0xFFA74CDF);
  static const Color tertiaryColor = Colors.white;

  static const Color primaryBG = Color(0xFF0D1117);
  static const Color cardBG = Color(0xFF1A1D29);
  static const Color inputBG = Color(0xFF1A1D29);
  static const Color appBarBG = Color(0xFF1A1D29);
  static const Color labelColor = Color(0xFFACB1B8);
  static const Color hintColor = Color(0xFF6E7681);

  static const Color error = Colors.red;

  String primaryFontFamily = "Poppins";
  String secondaryFontFamily = "Roboto";

  static TextStyle get title1 => GoogleFonts.getFont(
        "IBM Plex Mono",
        color: const Color(0xFF04AFD3),
        fontWeight: FontWeight.w500,
        fontSize: 24,
        fontStyle: FontStyle.normal,
      );
  static TextStyle get title2 => GoogleFonts.getFont(
        "Roboto",
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 22,
      );
  static TextStyle get title3 => GoogleFonts.getFont(
        "Roboto",
        color: tertiaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  static TextStyle get subtitle1 => GoogleFonts.getFont(
        "Roboto Mono",
        color: tertiaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  static TextStyle get subtitle2 => GoogleFonts.getFont(
        "Roboto Mono",
        color: tertiaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 15,
      );
  static TextStyle get bodyText1 => GoogleFonts.getFont(
        "Roboto",
        color: tertiaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  static TextStyle get bodyText2 => GoogleFonts.getFont(
        "Roboto",
        color: tertiaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      );

  static ThemeData get themeData => ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      backgroundColor: primaryBG,
      scaffoldBackgroundColor: primaryBG,
      primaryColor: primaryColor,
      bottomAppBarTheme: ThemeData.dark().bottomAppBarTheme.copyWith(
        color: appBarBG,
      ),
      textTheme: ThemeData.dark().textTheme.copyWith(
        headline1: title1,
        headline2: title2,
        headline3: title3,
        subtitle1: subtitle1,
        subtitle2: subtitle2,
        bodyText1: bodyText1,
        bodyText2: bodyText1,
      ),
      cardColor: cardBG,
      inputDecorationTheme: ThemeData.dark().inputDecorationTheme.copyWith(
        fillColor: inputBG,
        hintStyle: subtitle2.copyWith(color: hintColor),
        labelStyle: subtitle1.copyWith(color: labelColor),
        helperStyle: subtitle2,
      ),
      appBarTheme: ThemeData.dark().appBarTheme.copyWith(
        backgroundColor: primaryColor,
        actionsIconTheme: ThemeData.dark().iconTheme,
        titleTextStyle: title2
            .override(fontFamily: "IBM Plex Mono", fontSize: 28),
      ));
}

extension TextStyleHelper on TextStyle {
  TextStyle override(
          {String? fontFamily,
          Color? color,
          double? fontSize,
          FontWeight? fontWeight,
          FontStyle? fontStyle}) =>
      GoogleFonts.getFont(
        fontFamily ?? fontFamilyFallback![0],
        color: color ?? this.color,
        fontSize: fontSize ?? this.fontSize,
        fontWeight: fontWeight ?? this.fontWeight,
        fontStyle: fontStyle ?? this.fontStyle,
      );
}