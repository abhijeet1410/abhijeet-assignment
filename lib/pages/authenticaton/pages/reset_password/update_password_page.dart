import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/app_decorations.dart';
import 'package:flutter_mobile_template/pages/authenticaton/controllers/update_password_controller.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class UpdatePasswordPage extends StatefulWidget {
  static const routeName = '/update-password';

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  late UpdatePasswordController _updatePasswordController;

  @override
  void initState() {
    super.initState();
    _updatePasswordController = UpdatePasswordController();
    _updatePasswordController.onInit();
  }

  @override
  void dispose() {
    _updatePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Obx(
          () => Form(
            key: _updatePasswordController.formKey,
            autovalidateMode: _updatePasswordController.autoValidateMode.value,
            child: Column(
              children: [
                Spacer(),
                Text('Update password', style: TextStyle(fontSize: 26)),
                SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 18),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (s) =>
                              FocusScope.of(context).nextFocus(),
                          onSaved: _updatePasswordController.onPasswordSaved,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          validator:
                              _updatePasswordController.passwordValidator,
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                                      hintText: 'New password',
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: Icon(Icons.lock),
                                      )),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (s) =>
                              FocusScope.of(context).nextFocus(),
                          onSaved:
                              _updatePasswordController.onConfirmPasswordSaved,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          validator: _updatePasswordController.confirmValidator,
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                                      hintText: 'Confirm password',
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: Icon(
                                          Icons.lock,
                                        ),
                                      )),
                        ),
                        SizedBox(height: 14),
                        AppPrimaryButton(
                            key: _updatePasswordController.buttonKey,
                            child: Text('Submit'),
                            onPressed: () => _updatePasswordController
                                .updatePassword(context)),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                Spacer(flex: 6)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
