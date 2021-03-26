import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/app_assets.dart';
import 'package:flutter_mobile_template/app_configs/app_decorations.dart';
import 'package:flutter_mobile_template/pages/authenticaton/controllers/register_controller.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_circle_button.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class RegisterPage extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterController _registerController;
  @override
  void initState() {
    super.initState();
    _registerController = RegisterController();
    _registerController.onInit();
  }

  @override
  void dispose() {
    _registerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Obx(
        () => Form(
          key: _registerController.formKey,
          autovalidateMode: _registerController.autoValidateMode.value,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onSaved: _registerController.onNameSaved,
                  onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
                  validator: (value) =>
                      _registerController.nameValidator(value, context),
                  decoration:
                      AppDecorations.textFieldDecoration(context).copyWith(
                    prefixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Icon(Icons.person)),
                    labelText: 'Name',
                    hintText: 'John Doe',
                  ),
                ),
                SizedBox(height: 14),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: _registerController.onEmailSaved,
                  onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
                  validator: (value) =>
                      _registerController.emailValidator(value, context),
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
                  obscureText: _registerController.isObscure.value ?? true,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (v) =>
                      _registerController.registerEmailAddress,
                  onSaved: _registerController.onPasswordSaved,
                  validator: _registerController.passwordValidator,
                  decoration:
                      AppDecorations.textFieldDecoration(context).copyWith(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Icon(Icons.email),
                          ),
                          labelText: 'Password',
                          hintText: '********',
                          suffixIcon: GestureDetector(
                            onTap: _registerController.toggleObscure,
                            child: Icon(
                                _registerController.isObscure.value ?? true
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded),
                          )),
                ),
                SizedBox(height: 28),
                AppPrimaryButton(
                  child: Text('Register'),
                  onPressed: _registerController.registerEmailAddress,
                  key: _registerController.buttonKey,
                ),
                SizedBox(height: 12),
                Text(
                  'Or Register using',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  children: [
                    if (Platform.isIOS)
                      AppCircleButton(
                        onPressed: () => _registerController.socialSignIn(3),
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
                    AppCircleButton(
                      onPressed: () => _registerController.socialSignIn(1),
                      child: SvgPicture.asset(AppAssets.google),
                    ),
                    AppCircleButton(
                      onPressed: () => _registerController.socialSignIn(2),
                      child: SvgPicture.asset(AppAssets.facebook),
                    ),
                    if (!Platform.isIOS)
                      AppCircleButton(
                        onPressed: () => _registerController.socialSignIn(3),
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
