import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin AppColors {
  static const brightBackground = Color(0xfff8f8f8);
  static const darkBackground = Color(0xff3e3e3e);
  static const borderColor = Color(0xffCEDCE5);
  static const brightSecondaryColor = Color(0xff3E9AFF);
  static const green = Color(0xff56AB18);
  static const divider = Color(0xffF1F1F1);
  static const darkGrey = Color(0xff676F75);
  static const prescriptionEnabled = Color(0xff24A7FF);

  static const MaterialColor brightPrimary =
      MaterialColor(_brightPrimaryValue, <int, Color>{
    50: Color(0xFF284796),
    100: Color(0xFF284796),
    200: Color(0xFF284796),
    300: Color(0xFF284796),
    400: Color(0xFF284796),
    500: Color(_brightPrimaryValue),
    600: Color(0xFF284796),
    700: Color(0xFF284796),
    800: Color(0xFF284796),
    900: Color(0xFF284796),
  });
  static const int _brightPrimaryValue = 0xFF284796;

  static const MaterialColor brightAccent =
      MaterialColor(_brightAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_brightAccentValue),
    400: Color(0xFFB8E4FF),
    700: Color(0xFF9FDAFF),
  });
  static const int _brightAccentValue = 0xFFEBF8FF;
  static const MaterialColor darkprimary =
      MaterialColor(_darkprimaryPrimaryValue, <int, Color>{
    50: Color(0xFFFFE1E9),
    100: Color(0xFFFFB5C7),
    200: Color(0xFFFF84A2),
    300: Color(0xFFFF527C),
    400: Color(0xFFFF2D60),
    500: Color(_darkprimaryPrimaryValue),
    600: Color(0xFFFF073E),
    700: Color(0xFFFF0635),
    800: Color(0xFFFF042D),
    900: Color(0xFFFF021F),
  });
  static const int _darkprimaryPrimaryValue = 0xFFFF0844;

  static const MaterialColor darkprimaryAccent =
      MaterialColor(_darkprimaryAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_darkprimaryAccentValue),
    400: Color(0xFFFFBFC4),
    700: Color(0xFFFFA6AC),
  });
  static const int _darkprimaryAccentValue = 0xFFFFF2F3;
}
