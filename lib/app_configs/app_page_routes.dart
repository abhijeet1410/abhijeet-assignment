import 'package:ausicare_doctor/pages/authenticaton/pages/login/login_page.dart';
import 'package:ausicare_doctor/pages/dashboard/bindings/dashboard_binding.dart';
import 'package:ausicare_doctor/pages/dashboard/dashboard_page.dart';
import 'package:ausicare_doctor/pages/splash/binding/splash_binding.dart';
import 'package:ausicare_doctor/pages/splash/splash_screen.dart';
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
          GetPage(name: LoginPage.routeName, page: () => LoginPage()),
          GetPage(
              name: DashboardPage.routeName,
              page: () => DashboardPage(),
              binding: DashboardBinding(),
              children: []),
        ]),
  ];
}
