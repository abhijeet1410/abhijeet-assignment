import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_template/app_configs/app_decorations.dart';
import 'package:flutter_mobile_template/app_configs/app_validators.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter_mobile_template/widgets/user_circle_avatar.dart';
import 'package:get/get.dart';

import 'forgot_password_update_password_controller.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class ForgotPasswordUpdatePage extends StatefulWidget {
  static const String routeName = '/ForgotPasswordUpdatePage';

  @override
  _ForgotPasswordUpdatePageState createState() =>
      _ForgotPasswordUpdatePageState();
}

class _ForgotPasswordUpdatePageState extends State<ForgotPasswordUpdatePage> {
  late ForgotPasswordUpdateController _loginController;

  @override
  void initState() {
    super.initState();
    _loginController = ForgotPasswordUpdateController();
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
                child: Text("Create a strong password to secure your account",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyText1!
                        .copyWith(fontSize: 16, height: 1.3)),
              ),
              const SizedBox(height: 34),
              UserCircleAvatar(
                "https://avatars.githubusercontent.com/u/42208638?v=4",
                radius: 74,
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
                          // onSaved: _loginController.onNameSaved,
                          // onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
                          // validator: (value) =>
                          //     _loginController.nameValidator(value, context),
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            labelText: 'Full Name',
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: TextFormField(
                          onSaved: _loginController.onPasswordSaved,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: _loginController.onPasswordSaved,
                          // onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
                          validator: (value) =>
                              AppFormValidators.validateEmpty(value, context),
                          textInputAction: TextInputAction.done,
                          // onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            labelText: 'Enter password',
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          onSaved: _loginController.onConfirmPasswordSaved,
                          onChanged: _loginController.onConfirmPasswordSaved,
                          // onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
                          validator: (value) => _loginController
                              .confirmPasswordValidator(value, context),
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            labelText: 'Confirm Password',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 54),
              AppPrimaryButton(
                child: Text('Continue'),
                onPressed: _loginController.updatePassword,
                key: _loginController.buttonKey,
              ),
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}
