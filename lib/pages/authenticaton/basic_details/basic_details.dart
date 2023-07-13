import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assignment_pay/app_configs/app_assets.dart';
import 'package:assignment_pay/app_configs/app_decorations.dart';
import 'package:assignment_pay/app_configs/app_validators.dart';
import 'package:assignment_pay/pages/authenticaton/basic_details/basic_details_controller.dart';
import 'package:assignment_pay/utils/snackbar_helper.dart';
import 'package:assignment_pay/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../app_configs/app_colors.dart';
import '../../../widgets/app_buttons/app_back_button.dart';

class BasicDetailsPage extends StatefulWidget {
  static const String routeName = '/basic-details';

  const BasicDetailsPage({Key? key}) : super(key: key);

  @override
  _basicDetailsPageState createState() => _basicDetailsPageState();
}

class _basicDetailsPageState extends State<BasicDetailsPage> {
  late BasicDetailsController _basicDetailsController;
  bool isChecked = false;
  DateTime? _dob;
  TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer()..onTap = (){debugPrint('terms and condition page');};

  @override
  void initState() {
    super.initState();
    _basicDetailsController = Get.put(BasicDetailsController());
  }

  @override
  void dispose() {
    _basicDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Obx(() => Form(
                    key: _basicDetailsController.formKey,
                    autovalidateMode:
                        _basicDetailsController.autoValidateMode.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Basic Details",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 40),
                        const Text(
                            "Provide all your required details for your account.",
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 32),
                        TextFormField(
                          onSaved: _basicDetailsController.onFirstNameSaved,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: _basicDetailsController.onFirstNameSaved,
                          validator: (value) =>
                              AppFormValidators.validateEmpty(value, context),
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            hintText: 'Enter your First Name',
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          onSaved: _basicDetailsController.onLastNameSaved,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: _basicDetailsController.onLastNameSaved,
                          validator: (value) =>
                              AppFormValidators.validateEmpty(value, context),
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.done,
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            hintText: 'Enter your Last Name',
                          ),
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime(DateTime.now().year-18,DateTime.now().month,DateTime.now().day),
                                firstDate: DateTime(1922),
                                lastDate: DateTime(DateTime.now().year-18,DateTime.now().month,DateTime.now().day),);
                            if (picked != null && picked != _dob) {
                              _basicDetailsController.onSelectDOB(picked);
                              _dob = picked;
                              setState(() {});
                            }
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                color: theme.brightness == Brightness.light
                                    ? AppColors.lightGray
                                    : AppColors.textFieldDarkModeFillColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_dob == null
                                    ? 'Enter your date of birth'
                                    : DateFormat('dd/MM/yyyy').format(_dob!)),
                                SvgPicture.asset(
                                  AppAssets.calendar,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppColors.darkGray
                                      : AppColors.greyWhite,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Obx(() => Text(
                            _basicDetailsController.selectedUserType.value == 1
                                ? 'Provide your address'
                                : 'Provide your business address')),
                        const SizedBox(height: 32),
                        TextFormField(
                          onSaved:
                              _basicDetailsController.onAddressLineOneNameSaved,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged:
                              _basicDetailsController.onAddressLineOneNameSaved,
                          validator: (value) =>
                              AppFormValidators.validateEmpty(value, context),
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            hintText: 'Address line 1',
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          onSaved:
                              _basicDetailsController.onAddressLineTwoSaved,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged:
                              _basicDetailsController.onAddressLineTwoSaved,
                          validator: (value) =>
                              AppFormValidators.validateEmpty(value, context),
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            hintText: 'Address line 2',
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          onSaved: _basicDetailsController.onStreetSaved,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: _basicDetailsController.onStreetSaved,
                          validator: (value) =>
                              AppFormValidators.validateEmpty(value, context),
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            hintText: 'Street',
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          onSaved: _basicDetailsController.onCityOrTownSaved,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: _basicDetailsController.onCityOrTownSaved,
                          validator: (value) =>
                              AppFormValidators.validateEmpty(value, context),
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            hintText: 'City/Town',
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          onSaved: _basicDetailsController.onPinCodeSaved,
                          keyboardType: TextInputType.phone,
                          onChanged: _basicDetailsController.onPinCodeSaved,
                          validator: (value) =>
                              AppFormValidators.validateEmpty(value, context),
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            hintText: 'Postal code',
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        CheckboxListTile(
                          activeColor: AppColors.black,
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          title:
                              RichText(text: TextSpan(
                                text: 'I have read and I agree to the ',
                                style: const TextStyle(
                                  letterSpacing: 0.25,
                                  color: AppColors.lightBlack,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Terms and Conditions',
                                    recognizer: tapGestureRecognizer,
                                    style: const TextStyle(
                                      color: AppColors.brightPrimary
                                    )
                                  ),
                                  const TextSpan(
                                      text: ', and the ',
                                      style: TextStyle(
                                        letterSpacing: 0.25,
                                        color: AppColors.lightBlack,
                                      ),),
                                  TextSpan(
                                      text: 'Privacy Policy',
                                      recognizer: tapGestureRecognizer,
                                      style: const TextStyle(
                                          color: AppColors.brightPrimary
                                      )
                                  ),
                                  const TextSpan(
                                    text: '.',
                                    style: TextStyle(
                                      letterSpacing: 0.25,
                                      color: AppColors.lightBlack,
                                    ),),
                                ]
                              )),
                          // const Text(
                          //     'I have read and I agree to the Terms and Conditions, and the Privacy Policy.',
                          //     style: TextStyle(
                          //         fontSize: 14,
                          //         letterSpacing: 0.25,
                          //         color: AppColors.lightBlack,
                          //         fontWeight: FontWeight.w400)),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40, top: 40),
                          child: AppPrimaryButton(
                            child: const Text('Next'),
                            onPressed: () {
                              if (!isChecked) {
                                SnackBarHelper.show(
                                    "Please accept the terms and conditions to continue");
                              } else {
                                _basicDetailsController.saveBasicDetails();
                              }
                            },
                            key: _basicDetailsController.buttonKey,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
