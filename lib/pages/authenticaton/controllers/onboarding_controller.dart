import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:god_flutter/pages/authenticaton/pages/onboarding/onboarding_page.dart';
import 'package:god_flutter/pages/authenticaton/pages/onboarding/otp_verification_page.dart';
import 'package:god_flutter/pages/dashboard/dashboard_page.dart';
import 'package:god_flutter/utils/app_auth_helper.dart';
import 'package:god_flutter/utils/shared_preference_helper.dart';
import 'package:god_flutter/utils/snackbar_helper.dart';
import 'package:god_flutter/widgets/app_buttons/app_primary_button.dart';

///
/// Created By Sunil Kumar (sunil@smarttersstudio.com) on 14/04/2021
///
class OnBoardingController extends GetxController {
  String? _phone, _name;
  int? _gender;
  DateTime? _dateOfBirth;

  String? initialPhone, initialName;
  int? initialGender;
  DateTime? initialDateOfBirth;

  String? _parentPath;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic>? args = Get.arguments as Map<String, dynamic>;
    if (args != null) {
      initialPhone = args['phone'];
      initialName = args['name'];
      initialDateOfBirth = args['dob'];
      initialGender = args['gender'];
      _parentPath = args["parent"];
    }
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
  }

  @override
  void dispose() {
    autoValidateMode.close();
    super.dispose();
  }

  String? nameValidator(String? value, {BuildContext? context}) {
    if (value == null || value.trim().isEmpty) {
      return '*required';
    }
    return null;
  }

  void onNameSaved(String? newValue) {
    _name = newValue!.trim();
  }

  String? genderValidator(int? value, {BuildContext? context}) {
    if (value == null) {
      return '*required';
    }
    return null;
  }

  void onGenderSaved(int? newValue) {
    _gender = newValue;
  }

  String? dobValidator(DateTime? value, {BuildContext? context}) {
    if (value == null) {
      return '*required';
    }
    return null;
  }

  void onDobSaved(DateTime? newValue) {
    _dateOfBirth = newValue;
  }

  void saveUser() async {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      try {
        buttonKey.currentState?.showLoader();
        if (initialPhone != _phone) {
          await AuthHelper.userLoginWithPhone(_phone!);
          final otpResult = await Get.toNamed(OtpVerificationPage.routeName,
              arguments: {
                'phone': _phone,
                'parent': OnboardingPage.routeName,
                'isFromOnBoarding': true
              });
          if (otpResult != null && otpResult is bool && !otpResult) {
            throw 'Please verify phone to update.';
          }
        }
        if (SharedPreferenceHelper.accessToken != null &&
            SharedPreferenceHelper.user!.user == null) {
          await AuthHelper.signUpUser({
            'name': _name,
            'phone': _phone,
            "gender": _gender,
            "dob": _dateOfBirth!.toIso8601String(),
          });
        } else {
          if (initialName != _name)
            await AuthHelper.updateUser({'name': _name});
          await AuthHelper.updateUserDetails({
            if (_gender != initialGender) "gender": _gender,
            if (_dateOfBirth != initialDateOfBirth)
              "dob": _dateOfBirth!.toIso8601String(),
          });
        }
        buttonKey.currentState?.hideLoader();
        if (_parentPath != null) {
          Get.until((route) => route.settings.name == _parentPath);
        } else {
          Get.offAllNamed(DashboardPage.routeName);
        }
      } catch (e, s) {
        log('Error $e', stackTrace: s);
        buttonKey.currentState?.hideLoader();
        SnackBarHelper.show("", e.toString());
      }
    }
  }

  String? phoneValidator(String? value, {BuildContext? context}) {
    if (value == null || value.trim().isEmpty) {
      return '*required';
    } else {
      if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
        return 'Not a valid phone number.';
      } else
        return null;
    }
  }

  void onPhoneSaved(String? newValue) {
    _phone = newValue!.trim();
  }
}
