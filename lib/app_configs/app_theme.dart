import 'package:flutter/material.dart';
import 'package:assignment_pay/app_configs/environment.dart';

import 'app_colors.dart';

mixin AppThemes {
  static final lightTheme = ThemeData(
    fontFamily: Environment.fontFamily,
    canvasColor: AppColors.brightBackground,
    primarySwatch: AppColors.brightPrimary,
    primaryColor: AppColors.brightPrimary,
    accentColor: AppColors.brightPrimary,
    backgroundColor: AppColors.brightBackground,
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.brightPrimary,
        selectionHandleColor: AppColors.brightPrimary,
        selectionColor: AppColors.brightPrimary.withOpacity(0.3)),
    iconTheme: const IconThemeData(color: Colors.black),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(primary: AppColors.brightPrimary),
    ),
    // textTheme: TextTheme(
    //   bodyText1:
    //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
    //   bodyText2:
    //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
    // ),
  );
  static final darkTheme = ThemeData(
    fontFamily: Environment.fontFamily,
    canvasColor: AppColors.darkBackground,
    backgroundColor: AppColors.darkBackground,
    primarySwatch: AppColors.brightPrimary,
    primaryColor: AppColors.brightPrimary,
    accentColor: AppColors.brightPrimary,
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.brightPrimary,
        selectionHandleColor: AppColors.brightPrimary,
        selectionColor: AppColors.brightPrimary.withOpacity(0.3)),
    iconTheme: const IconThemeData(color: Colors.black),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(primary: AppColors.brightPrimary),
    ),
    // textTheme: TextTheme(
    //   bodyText1:
    //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
    //   bodyText2:
    //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
    // ),
  );
}
