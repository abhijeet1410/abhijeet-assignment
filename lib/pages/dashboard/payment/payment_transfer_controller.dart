import 'dart:developer';

import 'package:assignment_pay/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/app_buttons/app_primary_button.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class PaymentTransferController extends GetxController {
  String? userName, amount, _message;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;
  TextEditingController recipientSendingAmountController =
      TextEditingController();
  bool loading = false;
  double convertedAmount = 0.0;
  bool isWalletSelected = false;

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
  }

  @override
  void dispose() {
    autoValidateMode.close();
    super.dispose();
  }

  void onUserNameSaved(String? newValue) {
    userName = newValue?.trim();
  }

  void onAmountSaved(String? newValue) {
    amount = newValue?.trim();
    recipientSendingAmountController.text = '';
    update();
  }

  void onMessageSaved(String? newValue) {
    _message = newValue!.trim();
  }

  void onToggleWalletSelect(bool value) {
    isWalletSelected = value;
    update();
  }

  Future<void> makePayment(
    double amount,
    String recipientId,
    bool isFromWallet,
  ) async {
    try {

    } catch (_) {
      buttonKey.currentState!.hideLoader();
      SnackBarHelper.show(_.toString());
    }
  }

}
