import 'package:assignment_pay/pages/authenticaton/account_created/account_create_page.dart';
import 'package:assignment_pay/utils/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:assignment_pay/data_models/user.dart';
import 'package:assignment_pay/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

class BasicDetailsController extends GetxController {
  String? _firstName,
      _lastName,
      _addressLineOne,
      _addressLineTwo,
      _street,
      _cityOrTown,
      _pinCode;
  User? _onBoardingUser;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;
  late bool validated;
  RxInt selectedUserType = RxInt(1);
  Rx<DateTime>? dob;

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> _args = Get.arguments;
    _onBoardingUser = _args['onBoardingUser'];
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    validated = false;
  }

  @override
  void dispose() {
    autoValidateMode.close();
    super.dispose();
  }

  void onFirstNameSaved(String? newValue) {
    _firstName = newValue!.trim();
  }

  void onLastNameSaved(String? newValue) {
    _lastName = newValue!.trim();
  }

  void onAddressLineOneNameSaved(String? newValue) {
    _addressLineOne = newValue!.trim();
  }

  void onAddressLineTwoSaved(String? newValue) {
    _addressLineTwo = newValue!.trim();
  }

  void onStreetSaved(String? newValue) {
    _street = newValue!.trim();
  }

  void onCityOrTownSaved(String? newValue) {
    _cityOrTown = newValue!.trim();
  }

  void onPinCodeSaved(String? newValue) {
    _pinCode = newValue!.trim();
  }

  void onSelectUserType(int type) {
    selectedUserType.value = type;
  }

  void onSelectDOB(DateTime selectedDob) {
    if (dob == null) {
      dob = Rx(selectedDob);
    } else {
      dob!.value = selectedDob;
    }
  }

  void saveBasicDetails() {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      Address _address = Address(
          addressLine1: _addressLineOne,
          addressLine2: _addressLineTwo,
          city: _cityOrTown,
          pinCode: _pinCode,
          street: _street);
      _onBoardingUser!.firstName = _firstName;
      _onBoardingUser!.lastName = _lastName;
      _onBoardingUser!.address = _address;
      _onBoardingUser!.dob = dob!.value;
      SharedPreferenceHelper.storeUser(
          user: UserResponse(user: _onBoardingUser, accessToken: ''));
      Get.offAllNamed(CreatedAccountPage.routeName,
          arguments: {'onBoardingUser': _onBoardingUser});
    }
  }
}
