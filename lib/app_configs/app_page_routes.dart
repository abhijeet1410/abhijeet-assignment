import 'package:flutter_mobile_template/pages/authenticaton/forgot_password_phone/forgot_password_phone_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/forgot_password_phone_verification/forgot_password_phone_verification_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/forgot_password_update_password/forgot_password_update_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/login_email/login_email_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/login_otp/login_otp_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/login_phone/login_phone_page.dart';
import 'package:flutter_mobile_template/pages/authenticaton/register/register_page.dart';
import 'package:flutter_mobile_template/pages/dashboard/dashboard_page.dart';
import 'package:flutter_mobile_template/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppPages {
  /// NOT TO BE USE NOW
  static final pages = [
    GetPage(name: SplashPage.routeName, page: () => SplashPage()),
    GetPage(name: LoginEmailPage.routeName, page: () => LoginEmailPage()),
    GetPage(name: LoginOtpPage.routeName, page: () => const LoginOtpPage()),
    GetPage(name: LoginPhonePage.routeName, page: () => LoginPhonePage()),
    GetPage(name: RegisterPage.routeName, page: () => RegisterPage()),
    GetPage(
        name: ForgotPasswordPhonePage.routeName,
        page: () => ForgotPasswordPhonePage()),
    GetPage(
        name: ForgotPasswordUpdatePage.routeName,
        page: () => ForgotPasswordUpdatePage()),
    GetPage(
        name: ForgotPasswordVerificationPage.routeName,
        page: () => ForgotPasswordVerificationPage()),
    GetPage(
        name: DashboardPage.routeName,
        page: () => DashboardPage(),
        children: [])
  ];
}
