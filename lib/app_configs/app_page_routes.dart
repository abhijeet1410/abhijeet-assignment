import 'package:get/get.dart';
import 'package:god_flutter/pages/authentication/forgot_password/forgot_password_email_page.dart';
import 'package:god_flutter/pages/authentication/forgot_password/forgot_password_otp_page.dart';
import 'package:god_flutter/pages/authentication/forgot_password/forgot_password_update_page.dart';
import 'package:god_flutter/pages/authentication/intro/intro_page.dart';
import 'package:god_flutter/pages/authentication/login/login_email_otp_page.dart';
import 'package:god_flutter/pages/authentication/login/login_email_page.dart';
import 'package:god_flutter/pages/authentication/login/login_phone_otp_page.dart';
import 'package:god_flutter/pages/authentication/login/login_phone_page.dart';
import 'package:god_flutter/pages/authentication/onboarding/onboarding_page.dart';
import 'package:god_flutter/pages/authentication/register/register_email_otp_page.dart';
import 'package:god_flutter/pages/authentication/register/register_email_page.dart';
import 'package:god_flutter/pages/authentication/register/register_phone_otp_page.dart';
import 'package:god_flutter/pages/authentication/register/register_phone_page.dart';
import 'package:god_flutter/pages/dashboard/dashboard_page.dart';
import 'package:god_flutter/pages/splash/splash_screen.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppPages {
  static final pages = [
    GetPage(name: SplashPage.routeName, page: () => SplashPage()),
    GetPage(name: IntroPage.routeName, page: () => IntroPage()),
    GetPage(name: LoginEmailPage.routeName, page: () => LoginEmailPage()),
    GetPage(name: LoginPhonePage.routeName, page: () => LoginPhonePage()),
    GetPage(name: LoginEmailOtpPage.routeName, page: () => LoginEmailOtpPage()),
    GetPage(name: LoginPhoneOtpPage.routeName, page: () => LoginPhoneOtpPage()),
    GetPage(
        name: ForgotPasswordEmailPage.routeName,
        page: () => ForgotPasswordEmailPage()),
    GetPage(
        name: ForgotPasswordOtpPage.routeName,
        page: () => ForgotPasswordOtpPage()),
    GetPage(
        name: ForgotPasswordUpdatePage.routeName,
        page: () => ForgotPasswordUpdatePage()),
    GetPage(name: RegisterEmailPage.routeName, page: () => RegisterEmailPage()),
    GetPage(
        name: RegisterEmailOtpPage.routeName,
        page: () => RegisterEmailOtpPage()),
    GetPage(name: RegisterPhonePage.routeName, page: () => RegisterPhonePage()),
    GetPage(
        name: RegisterPhoneOtpPage.routeName,
        page: () => RegisterPhoneOtpPage()),
    GetPage(name: OnboardingPage.routeName, page: () => OnboardingPage()),
    GetPage(
        name: DashboardPage.routeName,
        page: () => DashboardPage(),
        children: []),
  ];
}
