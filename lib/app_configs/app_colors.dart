import 'package:flutter/material.dart';

mixin AppColors {
  static const brightBackground = Colors.white;
  static const darkBackground = Color(0xff1A1719);
  static const borderColor = Color(0xffCEDCE5);
  static const brightSecondaryColor = Color(0xff3E9AFF);
  static const green = Color(0xff29CC7A);
  static const blue = Color(0xff6392FF);
  static const paymentStatusYellow = Color(0xffFFB219);
  static const paymentStatusGreen = Color(0xff29CC7A);
  static const paymentStatusRed = Color(0xffCC1414);
  static const divider = Color(0xffF1F1F1);
  static const lightBlack = Color(0xff333333);
  static const black = Color(0xff000000);
  static const lightGray = Color(0xffF2F2F2);
  static const darkGray = Color(0xff787878);
  static const greyWhite = Color(0xffDADADA);
  static const textFieldDarkModeFillColor = Color(0xff423D4C);
  static const dividerColor = Color(0xffE5E5E5);
  static const dotColorActive = Color(0xffC4C4C4);
  static const dotColorInactive = Color(0xff4D4D4D);
  static const dashboardItemSelectedColor = Color(0xffFFDE59);
  static const darkBlue = Color(0xff110D1A);
  static const warningRed = Color(0xffD85656);
  static const deleteRed = Color(0xffE63D2E);
  static const darkModeDisabled = Color(0xff806680);
  static const lightModeDisabled = Color(0xff8C8C8C);
  static const lightPink = Color(0xffFFC0FF);
  static const lightPurple = Color(0xffCC52CC);
  static const peachPink = Color(0xffE5B8DE);
  static const grayLight = Color(0xff999999);

  static const MaterialColor brightPrimary =
  MaterialColor(brightPrimaryValue, <int, Color>{
    50: Color(0xFFF7E3F7),
    100: Color(0xFFECB8EC),
    200: Color(0xFFDF89DF),
    300: Color(0xFFD25AD2),
    400: Color(0xFFC936C9),
    500: Color(brightPrimaryValue),
    600: Color(0xFFB911B9),
    700: Color(0xFFB10EB1),
    800: Color(0xFFA90BA9),
    900: Color(0xFF9B069B),
  });
  static const int brightPrimaryValue = 0xFFBF13BF;

  static const MaterialColor darkPrimary =
  MaterialColor(darkPrimaryValue, <int, Color>{
    50: Color(0xFFF7E3F7),
    100: Color(0xFFECB8EC),
    200: Color(0xFFDF89DF),
    300: Color(0xFFD25AD2),
    400: Color(0xFFC936C9),
    500: Color(darkPrimaryValue),
    600: Color(0xFFB911B9),
    700: Color(0xFFB10EB1),
    800: Color(0xFFA90BA9),
    900: Color(0xFF9B069B),
  });
  static const int darkPrimaryValue = 0xFFBF13BF;

  static const MaterialColor darkprimaryAccent =
  MaterialColor(_darkprimaryAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_darkprimaryAccentValue),
    400: Color(0xFFFFBFC4),
    700: Color(0xFFFFA6AC),
  });
  static const int _darkprimaryAccentValue = 0xFFFFF2F3;
}
