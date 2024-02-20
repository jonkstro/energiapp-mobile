import 'package:energiapp/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';

class CustomTextFormField {
  static const lightTheme = InputDecorationTheme(
    filled: false,
    fillColor: ColorsConstants.backgroundPrimaryLight,
    border: OutlineInputBorder(),
    outlineBorder: BorderSide(width: 1),
    errorMaxLines: 10,
    errorStyle: TextStyle(
      fontSize: 16,
    ),
  );
  static const darkTheme = InputDecorationTheme(
    filled: true,
    fillColor: ColorsConstants.backgroundPrimaryDark,
    border: OutlineInputBorder(),
    outlineBorder: BorderSide(width: 1),
    errorMaxLines: 10,
    errorStyle: TextStyle(
      fontSize: 16,
    ),
  );
}
