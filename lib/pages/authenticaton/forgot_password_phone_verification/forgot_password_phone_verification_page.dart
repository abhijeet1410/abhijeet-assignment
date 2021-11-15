import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pro_health/app_configs/app_decorations.dart';
import 'package:pro_health/app_configs/environment.dart';
import 'package:pro_health/pages/authenticaton/login_phone/login_phone_page.dart';
import 'package:pro_health/widgets/app_buttons/app_primary_button.dart';

import 'forgot_password_phone_verification_controller.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class ForgotPasswordVerificationPage extends StatefulWidget {
  static const String routeName = '/ForgotPasswordVerificationPage';

  @override
  _ForgotPasswordVerificationPageState createState() =>
      _ForgotPasswordVerificationPageState();
}

class _ForgotPasswordVerificationPageState
    extends State<ForgotPasswordVerificationPage> {
  late ForgotPasswordVerificationController _loginController;

  @override
  void initState() {
    super.initState();
    _loginController = ForgotPasswordVerificationController();
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
                    "Please enter your details, a verification code will be sent to you",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyText1!
                        .copyWith(fontSize: 16, height: 1.3)),
              ),
              const SizedBox(height: 34),
              Obx(
                () => Form(
                  key: _loginController.formKey,
                  autovalidateMode: _loginController.autoValidateMode.value,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: TextFormField(
                          initialValue: _loginController.phone,
                          enabled: false,
                          textInputAction: TextInputAction.done,
                          // onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            labelText: 'Enter Phone Number',
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onSaved: _loginController.onCodeSaved,
                          // onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
                          validator: (value) =>
                              _loginController.codeValidator(value, context),
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            labelText: 'Verification Code',
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
                      onPressed: _loginController.resendOtp,
                      child: Text("Resend")),
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
