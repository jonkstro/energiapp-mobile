import 'package:energiapp/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';

class CustomButtonTheme {
  static final lightTheme = ElevatedButtonThemeData(
    style: _customStyle(),
  );
  static final darkTheme = ElevatedButtonThemeData(
    style: _customStyle(),
  );

  static ButtonStyle _customStyle() {
    return const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(ColorsConstants.primaryColor),
      foregroundColor: MaterialStatePropertyAll(ColorsConstants.bodyTextDark),
      elevation: MaterialStatePropertyAll(5),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }
}
