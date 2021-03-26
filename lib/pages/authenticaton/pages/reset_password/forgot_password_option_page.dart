import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/app_decorations.dart';
import 'package:flutter_mobile_template/pages/authenticaton/controllers/forgot_password_option_controller.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class ForgotPasswordOptionPage extends StatefulWidget {
  static const String routeName = '/ForgotPasswordOptionPage';

  @override
  _ForgotPasswordOptionPageState createState() =>
      _ForgotPasswordOptionPageState();
}

class _ForgotPasswordOptionPageState extends State<ForgotPasswordOptionPage> {
  late ForgotPasswordOptionController _optionController;

  @override
  void initState() {
    super.initState();
    _optionController = ForgotPasswordOptionController();
    _optionController.onInit();
  }

  @override
  void dispose() {
    _optionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color radioBackgroundColor = theme.brightness == Brightness.light
        ? Colors.grey.shade800
        : Colors.white;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Choose option'),
        ),
        body: SafeArea(
          child: Obx(
            () => Column(
              children: [
                SizedBox(height: 32),
                Text('Forgot password', style: TextStyle(fontSize: 26)),
                SizedBox(height: 12),
                Text(
                    'We will send you a 4 digit\ncode to your registered\nemail or phone number.\n\nPlease select your email or\nphone number for the\nverification process.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 18),
                      GestureDetector(
                        onTap: () => _optionController.setEmailChecked(true),
                        child: Row(
                          children: [
                            Material(
                              color: radioBackgroundColor,
                              type: MaterialType.circle,
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Material(
                                  type: MaterialType.circle,
                                  color: _optionController.radioCheckedColor(
                                      true, context),
                                  child: SizedBox(height: 18, width: 18),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                enabled: false,
                                initialValue: _optionController.email,
                                decoration:
                                    AppDecorations.textFieldDecoration(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 14),
                      GestureDetector(
                        onTap: () {
                          _optionController.isEmailChecked(false);
                        },
                        child: Row(
                          children: [
                            Material(
                              color: radioBackgroundColor,
                              type: MaterialType.circle,
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Material(
                                  type: MaterialType.circle,
                                  color: _optionController.radioCheckedColor(
                                      false, context),
                                  child: SizedBox(height: 18, width: 18),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                enabled: false,
                                initialValue: _optionController.phone,
                                decoration:
                                    AppDecorations.textFieldDecoration(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 14),
                      AppPrimaryButton(
                          key: _optionController.buttonKey,
                          child: Text('CONTINUE'),
                          onPressed: _optionController.sendOtp),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
