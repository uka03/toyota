import 'package:flutter/material.dart';
import 'package:toyota/utils/colors.dart';

extension GeneralTextStyles on TextTheme {
  static TextStyle bodyText(
    BuildContext context, {
    Color? textColor = GeneralColors.primaryTextColor,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle titleText(
    BuildContext context, {
    Color? textColor,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration? decoration,
  }) {
    return TextStyle(color: textColor ?? GeneralColors.primaryTextColor, fontSize: fontSize, fontWeight: fontWeight, decoration: decoration);
  }
}
