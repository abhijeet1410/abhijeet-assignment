import 'package:assignment_pay/pages/authenticaton/account_created/account_create_page.dart';
import 'package:assignment_pay/pages/authenticaton/basic_details/basic_details.dart';
import 'package:assignment_pay/pages/authenticaton/forgot_password_update_password/forgot_password_update_page.dart';
import 'package:assignment_pay/pages/authenticaton/login_email/login_email_page.dart';
import 'package:assignment_pay/pages/authenticaton/login_otp/login_otp_page.dart';
import 'package:assignment_pay/pages/authenticaton/register/register_page.dart';
import 'package:assignment_pay/pages/dashboard/dashboard_page.dart';
import 'package:assignment_pay/pages/dashboard/payment/payment_transfer_page.dart';
import 'package:assignment_pay/pages/my_account/components/my_details/pages/my_details_page.dart';
import 'package:assignment_pay/pages/my_account/pages/my_account_page.dart';
import 'package:assignment_pay/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppPages {
  /// NOT TO BE USE NOW
  static final pages = [
    GetPage(name: SplashPage.routeName, page: () => const SplashPage()),
    GetPage(name: LoginEmailPage.routeName, page: () => const LoginEmailPage()),
    GetPage(name: LoginOtpPage.routeName, page: () => const LoginOtpPage()),
    GetPage(name: RegisterPage.routeName, page: () => const RegisterPage()),
    GetPage(
        name: BasicDetailsPage.routeName, page: () => const BasicDetailsPage()),
    GetPage(name: MyAccountPage.routeName, page: () => const MyAccountPage()),
    GetPage(name: MyDetailsPage.routeName, page: () => const MyDetailsPage()),
    GetPage(name: PaymentPage.routeName, page: () => const PaymentPage()),
    GetPage(
        name: CreatedAccountPage.routeName,
        page: () => const CreatedAccountPage()),
    GetPage(
        name: ForgotPasswordUpdatePage.routeName,
        page: () => const ForgotPasswordUpdatePage()),
    GetPage(
        name: DashboardPage.routeName,
        page: () => DashboardPage(),
        children: [])
  ];
}
