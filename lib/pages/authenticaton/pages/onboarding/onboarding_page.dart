import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:god_flutter/app_configs/app_assets.dart';
import 'package:god_flutter/app_configs/app_colors.dart';
import 'package:god_flutter/app_configs/app_decorations.dart';
import 'package:god_flutter/pages/authenticaton/controllers/onboarding_controller.dart';
import 'package:god_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:god_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:intl/intl.dart';

class OnboardingPage extends StatefulWidget {
  static const routeName = '/onboarding';

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late OnBoardingController _onBoardingController; //

  @override
  void initState() {
    super.initState();
    _onBoardingController = OnBoardingController();
    _onBoardingController.onInit();
  }

  @override
  void dispose() {
    _onBoardingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Obx(
          () => Form(
            key: _onBoardingController.formKey,
            autovalidateMode: _onBoardingController.autoValidateMode.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Navigator.canPop(context))
                  AppBackButton(
                    padding: const EdgeInsets.all(16),
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal details',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Please enter following details to continue',
                          style: TextStyle(color: const Color(0xff929292)),
                        ),
                        SizedBox(height: 22),
                        Text(
                          'Full name',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          initialValue: _onBoardingController.initialName,
                          validator: _onBoardingController.nameValidator,
                          onSaved: _onBoardingController.onNameSaved,
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                                      prefixIconConstraints:
                                          BoxConstraints.tightFor(width: 54),
                                      prefixIcon:
                                          SvgPicture.asset(AppAssets.user)),
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                        ),
                        SizedBox(height: 22),
                        Text(
                          'Gender',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        FormField<int>(
                            initialValue: _onBoardingController.initialGender,
                            validator: _onBoardingController.genderValidator,
                            onSaved: _onBoardingController.onGenderSaved,
                            builder: (FormFieldState<int> state) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Expanded(
                                            child: GenderTile(
                                          gender: 1,
                                          isSelected: state.value == 1,
                                          onSelected: () => state.didChange(1),
                                        )),
                                        const SizedBox(width: 8),
                                        Expanded(
                                            child: GenderTile(
                                          gender: 2,
                                          isSelected: state.value == 2,
                                          onSelected: () => state.didChange(2),
                                        )),
                                        const SizedBox(width: 8),
                                        Expanded(
                                            child: GenderTile(
                                          gender: 3,
                                          isSelected: state.value == 3,
                                          onSelected: () => state.didChange(3),
                                        )),
                                      ]),
                                      if (state.hasError)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 6),
                                          child: Text('${state.errorText}',
                                              style: TextStyle(
                                                  color: theme.errorColor)),
                                        )
                                    ])),
                        const SizedBox(height: 22),
                        Text(
                          'Date of birth',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        FormField<DateTime>(
                            initialValue:
                                _onBoardingController.initialDateOfBirth,
                            validator: _onBoardingController.dobValidator,
                            onSaved: _onBoardingController.onDobSaved,
                            builder: (FormFieldState<DateTime> state) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Material(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          side: BorderSide(
                                            color: AppColors.borderColor,
                                            width: 1.2,
                                          ),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: InkWell(
                                          onTap: () async {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            final now = DateTime.now();
                                            final picked = await showDatePicker(
                                                context: context,
                                                firstDate: DateTime(
                                                    now.year - 100,
                                                    now.month,
                                                    now.day),
                                                lastDate: DateTime(
                                                    now.year - 13,
                                                    now.month,
                                                    now.day),
                                                initialDate: DateTime(
                                                    now.year - 13,
                                                    now.month,
                                                    now.day));
                                            if (picked != null) {
                                              state.didChange(picked);
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 16, 20, 16),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                    AppAssets.calendar),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                    child: state.value == null
                                                        ? SizedBox()
                                                        : Text(
                                                            DateFormat(
                                                                    'dd.MM.yyyy')
                                                                .format(state
                                                                    .value!),
                                                            style: theme
                                                                .textTheme
                                                                .subtitle1))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (state.hasError)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 6),
                                          child: Text('${state.errorText}',
                                              style: TextStyle(
                                                  color: theme.errorColor)),
                                        )
                                    ])),
                        const SizedBox(height: 22),
                        Text(
                          'Phone number',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          enabled:
                              _onBoardingController.initialPhone?.isEmpty ??
                                  true,
                          initialValue: _onBoardingController.initialPhone,
                          textInputAction: TextInputAction.done,
                          onSaved: _onBoardingController.onPhoneSaved,
                          validator: (v) => _onBoardingController
                              .phoneValidator(v, context: context),
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                                      hintText: 'xxxxxxxxxx',
                                      prefixIconConstraints:
                                          BoxConstraints.tightFor(width: 54),
                                      prefixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 12),
                                            child: Text('+91'),
                                          ),
                                          Container(
                                              height: 32,
                                              width: 1,
                                              color: AppColors.borderColor)
                                        ],
                                      )),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '*Phone number verification will be required.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 22),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 22),
                    child: AppPrimaryButton(
                        width: Get.width,
                        key: _onBoardingController.buttonKey,
                        child: Text('Continue'),
                        onPressed: _onBoardingController.saveUser),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenderTile extends StatelessWidget {
  final int gender;
  final bool isSelected;
  final VoidCallback onSelected;

  const GenderTile(
      {required this.gender,
      required this.isSelected,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String text = '';
    String asset = '';
    switch (gender) {
      case 1:
        text = 'Male';
        asset = AppAssets.male;
        break;
      case 2:
        text = 'Female';
        asset = AppAssets.female;
        break;
      default:
        text = 'Others';
        asset = AppAssets.others;
    }
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(
          color: isSelected ? theme.primaryColor : AppColors.borderColor,
          width: 1.2,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onSelected,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Row(
            children: [
              SvgPicture.asset(asset),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(text, style: theme.textTheme.subtitle1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
