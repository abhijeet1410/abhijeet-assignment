import 'package:flutter/material.dart';
import 'package:assignment_pay/app_configs/app_assets.dart';
import 'package:assignment_pay/pages/authenticaton/login_email/login_email_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../app_configs/app_colors.dart';

class CreatedAccountPage extends StatefulWidget {
  static const String routeName = '/account-created';

  const CreatedAccountPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordEmailPageState createState() =>
      _ForgotPasswordEmailPageState();
}

class _ForgotPasswordEmailPageState extends State<CreatedAccountPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Account created \n Successfully!!!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center),
              const SizedBox(height: 16),
              const Text(
                  "You can login to your account through the credentials created.",
                  style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => Get.offAllNamed(LoginEmailPage.routeName),
                child: const Text("LOGIN NOW",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.brightPrimary,
                        fontWeight: FontWeight.w500)),
              ),
              Expanded(
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.accountCreateVecor,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppAssets.info,
                      color: theme.brightness == Brightness.light
                          ? AppColors.lightBlack
                          : Colors.white),
                  const SizedBox(
                    width: 16,
                  ),
                  const Expanded(
                    child: Text(
                        "Account verification is pending, you can verify your account through the mail sent to your email.",
                        style: TextStyle(fontSize: 12, letterSpacing: 0.5)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
