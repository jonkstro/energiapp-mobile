import 'package:energiapp/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';

class CustomTextTheme {
  static final lightTheme = TextTheme(
    labelSmall: _customStyle(
      16,
      ColorsConstants.bodyTextLight,
      FontWeight.normal,
    ),
    labelMedium: _customStyle(
      16,
      ColorsConstants.bodyTextLight,
      FontWeight.bold,
    ),
    bodySmall: _customStyle(
      18,
      ColorsConstants.bodyTextLight,
      FontWeight.normal,
    ),
    bodyMedium: _customStyle(
      18,
      ColorsConstants.bodyTextLight,
      FontWeight.bold,
    ),
    headlineLarge: _customStyle(
      30,
      ColorsConstants.bodyTextLight,
      FontWeight.bold,
    ),
  );
  static final darkTheme = TextTheme(
    labelSmall: _customStyle(
      16,
      ColorsConstants.bodyTextDark,
      FontWeight.normal,
    ),
    labelMedium: _customStyle(
      16,
      ColorsConstants.bodyTextDark,
      FontWeight.bold,
    ),
    bodySmall: _customStyle(
      18,
      ColorsConstants.bodyTextDark,
      FontWeight.normal,
    ),
    bodyMedium: _customStyle(
      18,
      ColorsConstants.bodyTextDark,
      FontWeight.bold,
    ),
    headlineLarge: _customStyle(
      30,
      ColorsConstants.bodyTextDark,
      FontWeight.bold,
    ),
  );

  static TextStyle _customStyle(
      double fontSize, Color color, FontWeight fontWeight) {
    return TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  }
}
