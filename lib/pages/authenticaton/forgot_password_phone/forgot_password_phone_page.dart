import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_template/app_configs/app_decorations.dart';
import 'package:flutter_mobile_template/app_configs/app_validators.dart';
import 'package:flutter_mobile_template/app_configs/environment.dart';
import 'package:flutter_mobile_template/pages/authenticaton/login_phone/login_phone_page.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

import 'forgot_password_phone_controller.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class ForgotPasswordPhonePage extends StatefulWidget {
  static const String routeName = '/ForgotPasswordPhonePage';

  @override
  _ForgotPasswordPhonePageState createState() =>
      _ForgotPasswordPhonePageState();
}

class _ForgotPasswordPhonePageState extends State<ForgotPasswordPhonePage> {
  late ForgotPasswordPhoneController _loginController;

  @override
  void initState() {
    super.initState();
    _loginController = ForgotPasswordPhoneController();
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
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 22),
                child: Text(
                    "Please enter the registered phone number, an OTP will be sent to your number to recover the account",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyText1!
                        .copyWith(fontSize: 16, height: 1.3)),
              ),
              const SizedBox(height: 34),
              const SizedBox(height: 32),
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
                          // onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
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
              const SizedBox(height: 46),
              AppPrimaryButton(
                child: Text('Continue'),
                onPressed: _loginController.verifyPhoneNumber,
                key: _loginController.buttonKey,
              ),
              const SizedBox(height: 22),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(
                        fontFamily: Environment.fontFamily,
                        color: Colors.white),
                    children: [
                      TextSpan(
                          text: 'Already Have An Account?\n Click',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, height: 1.4),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                      TextSpan(
                          text: ' Here to Login',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                              color: theme.primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.offAllNamed(LoginPhonePage.routeName);
                            }),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
