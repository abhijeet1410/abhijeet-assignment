import 'package:flutter/material.dart';
import 'app_colors.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin AppThemes {
  static final lightTheme = ThemeData(
    canvasColor: AppColors.brightBackground,
    primarySwatch: AppColors.brightPrimary,
    primaryColor: AppColors.brightPrimary,
    accentColor: AppColors.brightPrimary,
    backgroundColor: AppColors.brightBackground,
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.brightPrimary,
        selectionHandleColor: AppColors.brightPrimary,
        selectionColor: AppColors.brightPrimary.withOpacity(0.3)),
    iconTheme: IconThemeData(color: Colors.black),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
            headline6: TextStyle(
                color: Color(0xff161616),
                fontSize: 18,
                fontWeight: FontWeight.w500))),
    // textTheme: TextTheme(
    //   bodyText1:
    //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
    //   bodyText2:
    //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
    // ),
  );
  static final darkTheme = ThemeData(
      canvasColor: AppColors.darkBackground,
      backgroundColor: AppColors.darkBackground,
      primarySwatch: AppColors.darkprimary,
      primaryColor: AppColors.darkprimary,
      accentColor: AppColors.darkprimary,
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.darkprimary,
          selectionHandleColor: AppColors.darkprimary,
          selectionColor: AppColors.brightPrimary.withOpacity(0.3)),
      iconTheme: IconThemeData(color: Colors.black),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      )
      // textTheme: TextTheme(
      //   bodyText1:
      //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
      //   bodyText2:
      //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
      // ),
      );
}
