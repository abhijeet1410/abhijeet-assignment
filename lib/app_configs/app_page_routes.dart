import 'package:flutter_mobile_template/pages/authenticaton/pages/intro/intro_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/login/login_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/register/register_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/reset_password/forgot_password_option_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/reset_password/forgot_password_otp_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/reset_password/forgot_password_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/reset_password/update_password_page.dart';
import 'package:flutter_mobile_template/pages/dashboard/bindings/dashboard_binding.dart';
import 'package:flutter_mobile_template/pages/dashboard/dashboard_page.dart';
import 'package:flutter_mobile_template/pages/dashboard/explore/explore_page.dart';
import 'package:flutter_mobile_template/pages/dashboard/home/home_page.dart';
import 'package:flutter_mobile_template/pages/dashboard/profile/profile_page.dart';
import 'package:flutter_mobile_template/pages/splash/binding/splash_binding.dart';
import 'package:flutter_mobile_template/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppPages {
  /// NOT TO BE USE NOW
  static final pages = [
    GetPage(
        name: SplashPage.routeName,
        page: () => SplashPage(),
        binding: SplashBinding(),
        children: [
          GetPage(name: IntroPage.routeName, page: () => IntroPage()),
          GetPage(name: LoginPage.routeName, page: () => LoginPage()),
          GetPage(name: RegisterPage.routeName, page: () => RegisterPage()),
          GetPage(
              name: ForgotPasswordOptionPage.routeName,
              page: () => ForgotPasswordOptionPage()),
          GetPage(
              name: ForgotPasswordOtpPage.routeName,
              page: () => ForgotPasswordOtpPage()),
          GetPage(
              name: ForgotPasswordPage.routeName,
              page: () => ForgotPasswordPage()),
          GetPage(
              name: UpdatePasswordPage.routeName,
              page: () => UpdatePasswordPage()),
          GetPage(
              name: DashboardPage.routeName,
              page: () => DashboardPage(),
              binding: DashboardBinding(),
              children: [
                GetPage(
                  name: HomePage.routeName,
                  page: () => HomePage(),
                ),
                GetPage(
                  name: ExplorePage.routeName,
                  page: () => ExplorePage(),
                ),
                GetPage(
                  name: ProfilePage.routeName,
                  page: () => ProfilePage(),
                ),
              ]),
        ]),
  ];
}
