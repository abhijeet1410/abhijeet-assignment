import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_template/app_configs/app_decorations.dart';
import 'package:flutter_mobile_template/app_configs/app_validators.dart';
import 'package:flutter_mobile_template/app_configs/environment.dart';
import 'package:flutter_mobile_template/pages/authenticaton/register/register_controller.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterController _loginController;

  @override
  void initState() {
    super.initState();
    _loginController = RegisterController();
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
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.done,
                          onSaved: _loginController.onNameSaved,
                          // onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
                          validator: (value) =>
                              AppFormValidators.validateEmpty(value, context),
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            labelText: 'Enter Full Name',
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
              const SizedBox(height: 46),
              AppPrimaryButton(
                child: Text('Continue'),
                onPressed: _loginController.registerPhoneNumber,
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
                              Get.back();
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
