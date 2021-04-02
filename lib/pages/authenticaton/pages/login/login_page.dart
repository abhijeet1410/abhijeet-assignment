import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/app_assets.dart';
import 'package:flutter_mobile_template/app_configs/app_decorations.dart';
import 'package:flutter_mobile_template/pages/authenticaton/controllers/login_controller.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/reset_password/forgot_password_page.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_circle_button.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController _loginController;
  @override
  void initState() {
    super.initState();
    _loginController = LoginController();
    _loginController.onInit();
  }

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Obx(
        () => Form(
          key: _loginController.formKey,
          autovalidateMode: _loginController.autoValidateMode.value,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: _loginController.onEmailSaved,
                  onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
                  validator: (value) =>
                      _loginController.emailValidator(value, context),
                  decoration:
                      AppDecorations.textFieldDecoration(context).copyWith(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Icon(Icons.email),
                    ),
                    labelText: 'Email-ID',
                    hintText: 'abc@gmail.com',
                  ),
                ),
                SizedBox(height: 14),
                TextFormField(
                  obscureText: _loginController.isObscure.value,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (v) => _loginController.loginEmailAddress,
                  onSaved: _loginController.onPasswordSaved,
                  validator: _loginController.passwordValidator,
                  decoration:
                      AppDecorations.textFieldDecoration(context).copyWith(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Icon(Icons.lock),
                          ),
                          labelText: 'Password',
                          hintText: '********',
                          suffixIcon: GestureDetector(
                            onTap: _loginController.toggleObscure,
                            child: Icon(_loginController.isObscure.value ?? true
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded),
                          )),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Get.toNamed(ForgotPasswordPage.routeName);
                        },
                        child: Text('Forgot password?'))),
                SizedBox(height: 22),
                AppPrimaryButton(
                  child: Text('Login'),
                  onPressed: _loginController.loginEmailAddress,
                  key: _loginController.buttonKey,
                ),
                SizedBox(height: 12),
                Text(
                  'Or Login using',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  children: [
                    if (Platform.isIOS)
                      AppCircleButton(
                        onPressed: () => _loginController.socialSignIn(3),
                        child: SizedBox(
                          height: 28,
                          width: 26,
                          child: CustomPaint(
                            painter: AppleLogoPainter(color: Colors.black),
                          ),
                        ),
                      ),
                    AppCircleButton(
                      onPressed: () => _loginController.socialSignIn(1),
                      child: SvgPicture.asset(AppAssets.google),
                    ),
                    AppCircleButton(
                      onPressed: () => _loginController.socialSignIn(2),
                      child: SvgPicture.asset(AppAssets.facebook),
                    ),
                    if (!Platform.isIOS)
                      AppCircleButton(
                        onPressed: () => _loginController.socialSignIn(3),
                        child: SizedBox(
                          height: 28,
                          width: 26,
                          child: CustomPaint(
                            painter: AppleLogoPainter(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
