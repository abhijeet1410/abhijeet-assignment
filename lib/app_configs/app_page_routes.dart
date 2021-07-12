import 'package:get/get.dart';
import 'package:god_flutter/pages/authenticaton/pages/login/login_page.dart';
import 'package:god_flutter/pages/dashboard/bindings/dashboard_binding.dart';
import 'package:god_flutter/pages/dashboard/dashboard_page.dart';
import 'package:god_flutter/pages/splash/binding/splash_binding.dart';
import 'package:god_flutter/pages/splash/splash_screen.dart';

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
