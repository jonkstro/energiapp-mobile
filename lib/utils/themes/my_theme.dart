import 'package:energiapp/utils/themes/custom/custom_colorscheme.dart';
import 'package:energiapp/utils/themes/custom/custom_text_form_field_theme.dart';
import 'package:energiapp/utils/themes/custom/custom_text_theme.dart';
import 'package:energiapp/utils/themes/custom/custon_button_theme.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    textTheme: CustomTextTheme.lightTheme,
    colorScheme: CustomColorScheme.lightTheme,
    inputDecorationTheme: CustomTextFormField.lightTheme,
    elevatedButtonTheme: CustomButtonTheme.lightTheme,
  );
  static final darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    textTheme: CustomTextTheme.darkTheme,
    colorScheme: CustomColorScheme.darkTheme,
    inputDecorationTheme: CustomTextFormField.darkTheme,
    elevatedButtonTheme: CustomButtonTheme.darkTheme,
  );
}
