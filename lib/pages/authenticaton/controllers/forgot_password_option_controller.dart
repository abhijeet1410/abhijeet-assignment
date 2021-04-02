///
/// Created by Kumar Sunil from Boiler plate
///
import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/reset_password/forgot_password_otp_page.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class ForgotPasswordOptionController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<AppPrimaryButtonState> buttonKey = GlobalKey();
  late RxBool isEmailChecked;
  late String email, phone, userId;

  @override
  void onInit() {
    super.onInit();
    isEmailChecked = RxBool(false);
    final args = Get.arguments as Map<String, dynamic>;
    email = args['email'];
    phone = args['phone'];
    userId = args['userId'];
  }

  @override
  void dispose() {
    isEmailChecked.close();
    super.dispose();
  }

  void setEmailChecked(bool b) {
    isEmailChecked.value = b;
  }

  Color radioCheckedColor(bool isFieldEmail, BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final selectedColor = isDarkMode ? Colors.grey.shade800 : Colors.white;

    if (isFieldEmail) {
      return isEmailChecked.value ? selectedColor : Colors.transparent;
    } else {
      return isEmailChecked.value ? Colors.transparent : selectedColor;
    }
  }

  void sendOtp() {
    Get.toNamed(ForgotPasswordOtpPage.routeName);
    // _buttonKey.currentState.showLoader();
    // AuthHelper.sendResetOtp(_userId, _isEmailChecked).then((value) {
    //   value['field'] = value['type'] == 'email' ? _email : _phone;
    //   Get.toNamed(ForgotPasswordOtpPage.routeName, arguments: value);
    // }).catchError((err, s) {
    //   SnackBarHelper.show('Error', '$err');
    // }).whenComplete(() => {_buttonKey.currentState.hideLoader()});
  }
}
