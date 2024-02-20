import 'package:energiapp/utils/themes/custom/custom_text_theme.dart';
import 'package:flutter/material.dart';

class CustomListTileTheme {
  static final lightTheme = ListTileThemeData(
    titleTextStyle: CustomTextTheme.lightTheme.labelMedium,
    subtitleTextStyle: CustomTextTheme.lightTheme.labelSmall,
  );
  static final darkTheme = ListTileThemeData(
    titleTextStyle: CustomTextTheme.darkTheme.labelMedium,
    subtitleTextStyle: CustomTextTheme.darkTheme.labelSmall,
  );
}
