import 'package:get/get.dart';
import 'package:pro_health/pages/authenticaton/login_email/login_email_page.dart';
import 'package:pro_health/pages/authenticaton/login_otp/login_otp_page.dart';
import 'package:pro_health/pages/authenticaton/login_phone/login_phone_page.dart';
import 'package:pro_health/pages/dashboard/dashboard_page.dart';
import 'package:pro_health/pages/splash/splash_screen.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppPages {
  /// NOT TO BE USE NOW
  static final pages = [
    GetPage(name: SplashPage.routeName, page: () => SplashPage()),
    GetPage(name: LoginEmailPage.routeName, page: () => LoginEmailPage()),
    GetPage(name: LoginOtpPage.routeName, page: () => LoginOtpPage()),
    GetPage(name: LoginPhonePage.routeName, page: () => LoginPhonePage()),
    GetPage(
        name: DashboardPage.routeName,
        page: () => DashboardPage(),
        children: [])
  ];
}
