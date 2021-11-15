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

  static const MaterialColor brightPrimary =
      MaterialColor(brightPrimaryValue, <int, Color>{
    50: Color(0xFFFCE9F0),
    100: Color(0xFFF8C8DA),
    200: Color(0xFFF4A3C2),
    300: Color(0xFFEF7EA9),
    400: Color(0xFFEB6296),
    500: Color(brightPrimaryValue),
    600: Color(0xFFE53F7C),
    700: Color(0xFFE23771),
    800: Color(0xFFDE2F67),
    900: Color(0xFFD82054),
  });
  static const int brightPrimaryValue = 0xFFE84684;

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
