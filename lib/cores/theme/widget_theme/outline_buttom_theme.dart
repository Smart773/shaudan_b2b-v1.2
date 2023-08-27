import 'package:flutter/material.dart';

class SOutlineButtonTheme {
  //Private Constructor
  SOutlineButtonTheme._();
  static OutlinedButtonThemeData lightTextTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 10),
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  ));
  static OutlinedButtonThemeData darkTextTheme = lightTextTheme;
}
