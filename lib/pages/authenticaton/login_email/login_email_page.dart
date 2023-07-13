import 'package:assignment_pay/app_configs/app_assets.dart';
import 'package:assignment_pay/app_configs/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assignment_pay/app_configs/app_decorations.dart';
import 'package:assignment_pay/app_configs/app_validators.dart';
import 'package:assignment_pay/app_configs/environment.dart';
import 'package:assignment_pay/pages/authenticaton/register/register_page.dart';
import 'package:assignment_pay/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'login_email_controller.dart';

class LoginEmailPage extends StatefulWidget {
  static const String routeName = '/login-email';

  const LoginEmailPage({Key? key}) : super(key: key);

  @override
  _LoginEmailPageState createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  late LoginEmailController _loginController;

  @override
  void initState() {
    super.initState();
    _loginController = LoginEmailController();
    _loginController.onInit();
  }

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showSignUp = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 54),
                      const Text(
                        "Hey!",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Welcome back.",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Enter your registered email ID and \npassword.",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Obx(
                            () => Form(
                          key: _loginController.formKey,
                          autovalidateMode:
                          _loginController.autoValidateMode.value,
                          child: Column(
                            children: [
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                onSaved: _loginController.onEmailSaved,
                                validator: (value) =>
                                    AppFormValidators.validateMail(
                                        value, context),
                                decoration:
                                AppDecorations.textFieldDecoration(context)
                                    .copyWith(
                                    hintText: 'Enter email ID',
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(18),
                                      child: SvgPicture.asset(
                                          AppAssets.email,
                                          color: Theme.of(context)
                                              .brightness ==
                                              Brightness.light
                                              ? AppColors.darkGray
                                              : AppColors.greyWhite),
                                    )),
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                obscureText:
                                _loginController.isPasswordhidden.value,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                onSaved: _loginController.onPasswordSaved,
                                validator: (value) =>
                                    AppFormValidators.validateEmpty(
                                        value, context),
                                decoration:
                                AppDecorations.textFieldDecoration(context)
                                    .copyWith(
                                    hintText: 'Enter Password',
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(18),
                                      child: SizedBox(
                                        width: 16,
                                        height: 15,
                                        child: SvgPicture.asset(
                                            AppAssets.lock,
                                            fit: BoxFit.fill,
                                            color: Theme.of(context)
                                                .brightness ==
                                                Brightness.light
                                                ? AppColors.darkGray
                                                : AppColors.greyWhite),
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      splashColor:
                                      Get.theme.backgroundColor,
                                      onPressed: () {
                                        _loginController
                                            .updateObsecure();
                                      },
                                      icon: SvgPicture.asset(
                                          _loginController
                                              .isPasswordhidden
                                              .value
                                              ? AppAssets.eye
                                              : AppAssets.hideEye,
                                          color: Theme.of(context)
                                              .brightness ==
                                              Brightness.light
                                              ? AppColors.darkGray
                                              : AppColors.greyWhite),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: AppPrimaryButton(
                          child: const Text('LOGIN'),
                          onPressed: _loginController.onLogin,
                          key: _loginController.buttonKey,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // RichText(
                      //   text: TextSpan(
                      //     children: <TextSpan>[
                      //       TextSpan(
                      //           text: 'Forgot Password? ',
                      //           style: TextStyle(
                      //             fontFamily: Environment.fontFamily,
                      //             fontSize: 16,
                      //             color: Theme.of(context).brightness ==
                      //                 Brightness.light
                      //                 ? AppColors.lightBlack
                      //                 : Colors.white,
                      //             fontWeight: FontWeight.w400,
                      //           )),
                      //       TextSpan(
                      //           text: 'RESET PASSWORD',
                      //           recognizer: TapGestureRecognizer()
                      //             ..onTap = () {
                      //               Get.toNamed(
                      //                   ForgotPasswordEmailPage.routeName);
                      //             },
                      //           style: TextStyle(
                      //             fontFamily: Environment.fontFamily,
                      //             fontSize: 16,
                      //             color: Get.theme.primaryColor,
                      //             fontWeight: FontWeight.w500,
                      //           )),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Center(
                child: showSignUp
                    ? RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Don’t have an account? ',
                          style: TextStyle(
                            fontFamily: Environment.fontFamily,
                            fontSize: 16,
                            color: Theme.of(context).brightness ==
                                Brightness.light
                                ? AppColors.lightBlack
                                : Colors.white,
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: 'SIGN UP',
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => Get.toNamed(RegisterPage.routeName),
                          style: TextStyle(
                            fontFamily: Environment.fontFamily,
                            fontSize: 16,
                            color: Get.theme.primaryColor,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                )
                    : const SizedBox(
                  width: 0,
                  height: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
