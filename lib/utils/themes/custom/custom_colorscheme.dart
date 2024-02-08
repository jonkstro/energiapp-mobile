import 'package:energiapp/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';

class CustomColorScheme {
  static const lightTheme = ColorScheme.light(
    primary: ColorsConstants.primaryColor,
    secondary: ColorsConstants.secondaryColor,
    background: ColorsConstants.backgroundPrimaryLight,
    onBackground: ColorsConstants.backgroundSecondaryLight,
    onPrimary: ColorsConstants.primaryColor,
  );
  static const darkTheme = ColorScheme.dark(
    primary: ColorsConstants.primaryColor,
    secondary: ColorsConstants.secondaryColor,
    background: ColorsConstants.backgroundPrimaryDark,
    onBackground: ColorsConstants.backgroundSecondaryDark,
    onPrimary: ColorsConstants.backgroundPrimaryLight,
  );
}
