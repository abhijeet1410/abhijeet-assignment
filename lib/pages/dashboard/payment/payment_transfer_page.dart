import 'dart:ui';
import 'package:assignment_pay/app_configs/app_validators.dart';
import 'package:assignment_pay/pages/base_page.dart';
import 'package:assignment_pay/pages/dashboard/payment/payment_transfer_controller.dart';
import 'package:assignment_pay/utils/notification_services/in_app_notification.dart';
import 'package:assignment_pay/utils/snackbar_helper.dart';
import 'package:assignment_pay/widgets/app_buttons/app_primary_button.dart';
import 'package:assignment_pay/widgets/user_circle_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:assignment_pay/app_configs/app_assets.dart';
import 'package:assignment_pay/app_configs/app_colors.dart';
import 'package:assignment_pay/data_models/user.dart';
import 'package:assignment_pay/pages/base_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app_configs/app_decorations.dart';
import '../../../widgets/app_buttons/app_back_button.dart';

class PaymentPage extends BasePage {
  static const String routeName = '/PaymentPage';

  const PaymentPage({Key? key}) : super(key: key);

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends BasePageState<PaymentPage> {
  late TextEditingController _userNameController,
      _sendingAmountController,
      _messageController;
  User? _recipient;
  late PaymentTransferController _paymentController;
  bool _isWalletSelected = false;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _sendingAmountController = TextEditingController()
      ..addListener(() {});
    _messageController = TextEditingController();
    _paymentController = Get.put(PaymentTransferController());
    _paymentController.onInit();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _sendingAmountController.dispose();
    super.dispose();
  }

  @override
  Widget body(BuildContext context) {
    final bool showSendButton = MediaQuery
        .of(context)
        .viewInsets
        .bottom == 0.0;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Obx(
                    () =>
                    Form(
                      key: _paymentController.formKey,
                      autovalidateMode: _paymentController.autoValidateMode
                          .value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ScrollConfiguration(
                              behavior: const ScrollBehavior()
                                  .copyWith(overscroll: false),
                              child: ListView(
                                  keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                                  children: [
                                    const Text("Transfer Money",
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w700)),
                                    const SizedBox(height: 32),
                                    const Text(
                                        "Provide a valid & full username the receiver.",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      controller: _userNameController,
                                      validator: (value) =>
                                          AppFormValidators.validateEmpty(
                                              value, context),
                                      decoration:
                                      AppDecorations.textFieldDecoration(
                                          context)
                                          .copyWith(
                                        hintText: 'Enter payee name',
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                        "Enter the amount you want to transfer.",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                            width: 86,
                                            height: 48,
                                            decoration: BoxDecoration(
                                                color: Theme
                                                    .of(context)
                                                    .brightness ==
                                                    Brightness.light
                                                    ? AppColors.lightGray
                                                    : AppColors
                                                    .textFieldDarkModeFillColor,
                                                borderRadius:
                                                BorderRadius.circular(15)),
                                            child: Center(
                                                child: Text("₹",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight
                                                            .w600,
                                                        color: !Get.isDarkMode
                                                            ? AppColors.darkGray
                                                            : AppColors
                                                            .greyWhite)))),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: TextFormField(
                                              controller: _sendingAmountController,
                                              textInputAction: TextInputAction
                                                  .done,
                                              onSaved:
                                              _paymentController.onAmountSaved,
                                              onChanged: (v) {
                                                _paymentController
                                                    .onAmountSaved(v);
                                                setState(() {});
                                              },
                                              onFieldSubmitted: (v) =>
                                              _paymentController.onAmountSaved,
                                              keyboardType: TextInputType
                                                  .number,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFeatures: [
                                                    FontFeature.liningFigures()
                                                  ]),
                                              decoration: AppDecorations
                                                  .textFieldDecoration(context)
                                                  .copyWith(
                                                hintText: 'Enter the amount',
                                              )),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 18),
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Message",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400))),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    TextFormField(
                                        controller: _messageController,
                                        textInputAction: TextInputAction.done,
                                        onChanged:
                                        _paymentController.onMessageSaved,
                                        onSaved: _paymentController
                                            .onMessageSaved,
                                        onFieldSubmitted: (v) =>
                                        _paymentController.onMessageSaved,
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400),
                                        decoration:
                                        AppDecorations.textFieldDecoration(
                                            context)
                                            .copyWith(
                                          hintText: 'optional',
                                        )),
                                    const SizedBox(height: 40),
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: showSendButton
                                ? Center(
                              child: AppPrimaryButton(
                                  key: _paymentController.buttonKey,
                                  child: const Text('PAY'),
                                  onPressed: (_sendingAmountController
                                      .text.isEmpty) ||
                                      (_userNameController.text.isEmpty)
                                      ? null
                                      : () {
                                    SnackBarHelper.show(
                                        "Your payment of ₹${_sendingAmountController
                                            .text
                                            .trim()} to ${_userNameController
                                            .text.trim()} is successful");
                                    InAppNotification.showNotification(
                                        title: "Payment Transfer",
                                        description:
                                        "Payment of ₹${_sendingAmountController
                                            .text
                                            .trim()} to ${_userNameController
                                            .text
                                            .trim()} is successful ${_messageController
                                            .text.isEmpty
                                            ? ""
                                            : "towards ${_messageController
                                            .text}"}");
                                    _sendingAmountController.clear();
                                    _userNameController.clear();
                                    _messageController.clear();
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    setState(() {});
                                  }),
                            )
                                : const SizedBox(
                              width: 0,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
              ))),
    );
  }
}
