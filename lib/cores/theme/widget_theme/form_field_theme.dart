import 'package:flutter/material.dart';

class FormFieldThemes {
  //Private Constructor
  FormFieldThemes._();
  static InputDecorationTheme lightTextTheme = InputDecorationTheme(
    hintStyle: const TextStyle(color: Colors.black54, fontSize: 12),
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.black87),
    ),
  );
  static InputDecorationTheme darkTextTheme = lightTextTheme;
}
