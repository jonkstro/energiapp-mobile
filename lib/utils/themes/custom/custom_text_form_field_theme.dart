import 'package:flutter/material.dart';

class CustomTextFormField {
  static const lightTheme = InputDecorationTheme(
    border: OutlineInputBorder(),
    outlineBorder: BorderSide(width: 1),
    // fillColor: ,
    errorMaxLines: 10,
    errorStyle: TextStyle(
      fontSize: 16,
    ),
  );
  static const darkTheme = InputDecorationTheme(
    border: OutlineInputBorder(),
    outlineBorder: BorderSide(width: 1),
    // fillColor: ,
    errorMaxLines: 10,
    errorStyle: TextStyle(
      fontSize: 16,
    ),
  );
}
