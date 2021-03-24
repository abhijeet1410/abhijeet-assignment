import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/pages/authenticaton/presentation/pages/intro/intro_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/presentation/pages/login/login_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/presentation/pages/register/register_page.dart';
import 'package:flutter_mobile_template/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppPages {
  static final pages = [
    // GetPage(
    //     name: Routes.HOME,
    //     page: () => HomeView(),
    //     binding: HomeBinding(),
    //     children: [
    //       GetPage(
    //         name: Routes.COUNTRY,
    //         page: () => CountryView(),
    //         children: [
    //           GetPage(
    //             name: Routes.DETAILS,
    //             page: () => DetailsView(),
    //           ),
    //         ],
    //       ),
    //     ]),
  ];
  static Map<String, Widget Function(BuildContext)> routes = {
    SplashPage.routeName: (ctx) => SplashPage(),
    IntroPage.routeName: (ctx) => IntroPage(),
    LoginPage.routeName: (ctx) => LoginPage(),
    RegisterPage.routeName: (ctx) => RegisterPage(),
  };
}
