import 'package:flutter/material.dart';
import 'package:shaudan_b2b/cores/theme/widget_theme/form_field_theme.dart';
import 'package:shaudan_b2b/cores/theme/widget_theme/outline_buttom_theme.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';

class AppTheme {
  //Private Constructor
  AppTheme._();
  static ThemeData appTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    primarySwatch: AppColors.themeColor,
    // textTheme: TextThemes.lightTextTheme,
    inputDecorationTheme: FormFieldThemes.lightTextTheme,
    outlinedButtonTheme: SOutlineButtonTheme.lightTextTheme,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.textColorLight,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    navigationRailTheme: const NavigationRailThemeData(
      backgroundColor: AppColors.whiteColor,
      selectedIconTheme: IconThemeData(
        color: AppColors.primaryColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: AppColors.textColorLight,
      ),
      selectedLabelTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
      unselectedLabelTextStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: AppColors.textColorLight,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(AppColors.primaryColor),
    ),
  );
}
