import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobile_template/app_configs/app_theme.dart';
import 'package:get/get.dart';

import 'generated/l10n.dart';
import 'pages/dashboard/profile/profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Mobile Template',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        // initialRoute: SplashPage.routeName,
        // routes: AppPages.routes,
        home: ProfilePage());
  }
}
