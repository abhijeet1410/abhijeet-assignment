import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pro_health/app_configs/app_decorations.dart';
import 'package:pro_health/app_configs/app_validators.dart';
import 'package:pro_health/app_configs/environment.dart';
import 'package:pro_health/pages/authenticaton/forgot_password_phone/forgot_password_phone_page.dart';
import 'package:pro_health/pages/authenticaton/register/register_page.dart';
import 'package:pro_health/widgets/app_buttons/app_primary_button.dart';

import 'login_phone_controller.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class LoginPhonePage extends StatefulWidget {
  static const String routeName = '/LoginPhonePage';

  @override
  _LoginPhonePageState createState() => _LoginPhonePageState();
}

class _LoginPhonePageState extends State<LoginPhonePage> {
  late LoginPhoneController _loginController;

  @override
  void initState() {
    super.initState();
    _loginController = LoginPhoneController();
    _loginController.onInit();
  }

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Form(
                  key: _loginController.formKey,
                  autovalidateMode: _loginController.autoValidateMode.value,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onSaved: _loginController.onPhoneSaved,
                          // onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
                          validator: (value) =>
                              AppFormValidators.validatePhone(value, context),
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            labelText: 'Enter Phone Number',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: TextButton(
                      style: TextButton.styleFrom(primary: Colors.white),
                      onPressed: () {
                        Get.toNamed(ForgotPasswordPhonePage.routeName);
                      },
                      child: Text("Forgot Password? Click Here")),
                ),
              ),
              const SizedBox(height: 46),
              Center(
                child: AppPrimaryButton(
                  child: Text('Login'),
                  onPressed: _loginController.loginPhoneNumber,
                  key: _loginController.buttonKey,
                ),
              ),
              const SizedBox(height: 54),
              Text(
                'Don\'t have An account?\nRegister Now',
                style: theme.textTheme.bodyText1!
                    .copyWith(fontSize: 16, height: 1.3),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 42),
              TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    fixedSize: Size(
                        MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.width / 3,
                        52),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 14,
                    ),
                    textStyle: TextStyle(
                      fontSize: 22,
                      fontFamily: Environment.fontFamily,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: Text("Register Now"),
                onPressed: () {
                  Get.toNamed(RegisterPage.routeName);
                },
              ),
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}
