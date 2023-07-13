import 'package:assignment_pay/app_configs/app_assets.dart';
import 'package:assignment_pay/app_configs/app_colors.dart';
import 'package:assignment_pay/widgets/app_buttons/app_back_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assignment_pay/app_configs/app_decorations.dart';
import 'package:assignment_pay/app_configs/app_validators.dart';
import 'package:assignment_pay/app_configs/environment.dart';
import 'package:assignment_pay/pages/authenticaton/register/register_controller.dart';
import 'package:assignment_pay/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterController _loginController;

  @override
  void initState() {
    super.initState();
    _loginController = RegisterController();
    _loginController.onInit();
  }

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showResetPassword =
        MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 56),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      const Text("Create your Login \ncredentials.",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 32),
                      const Text(
                          "Enter a password for your verified email ID to register to your account.",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400)),
                      Obx(
                        () => Form(
                          key: _loginController.formKey,
                          autovalidateMode:
                              _loginController.autoValidateMode.value,
                          child: Column(
                            children: [
                              const SizedBox(height: 32),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                initialValue: _loginController.email,
                                keyboardType: TextInputType.emailAddress,
                                onSaved: _loginController.onEmailSaved,
                                // onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
                                validator: (value) =>
                                    AppFormValidators.validateMail(
                                        value, context),
                                decoration:
                                    AppDecorations.textFieldDecoration(context)
                                        .copyWith(
                                  hintText: 'Enter email ID',
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(18),
                                    child: SvgPicture.asset(AppAssets.email,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? AppColors.lightModeDisabled
                                            : AppColors.darkModeDisabled),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                  obscureText: _loginController
                                      .isNewPasswordHidden.value,
                                  onSaved: _loginController.onPasswordSaved,
                                  keyboardType: TextInputType.visiblePassword,
                                  onChanged: _loginController.onPasswordSaved,
                                  // onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
                                  validator: (value) =>
                                      AppFormValidators.validatePassword(
                                          value, context),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (s) =>
                                      FocusScope.of(context).nextFocus(),
                                  decoration:
                                      AppDecorations.textFieldDecoration(
                                              context)
                                          .copyWith(
                                    hintText: 'Set Password',
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(18),
                                      child: SizedBox(
                                        width: 16,
                                        height: 15,
                                        child: SvgPicture.asset(AppAssets.lock,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? AppColors.darkGray
                                                    : AppColors.greyWhite),
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      splashColor: Get.theme.backgroundColor,
                                      highlightColor: Colors.transparent,
                                      onPressed: () {
                                        _loginController
                                                .isNewPasswordHidden.value =
                                            !_loginController
                                                .isNewPasswordHidden.value;
                                      },
                                      icon: SvgPicture.asset(
                                          _loginController
                                                  .isNewPasswordHidden.value
                                              ? AppAssets.eye
                                              : AppAssets.hideEye,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? AppColors.darkGray
                                              : AppColors.greyWhite),
                                    ),
                                  )),
                              const SizedBox(height: 24),
                              TextFormField(
                                  obscureText: _loginController
                                      .isConfirmPasswordHidden.value,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.visiblePassword,
                                  onSaved:
                                      _loginController.onConfirmPasswordSaved,
                                  onChanged:
                                      _loginController.onConfirmPasswordSaved,
                                  // onFieldSubmitted: (s) => FocusScope.of(context).nextFocus(),
                                  validator: (value) => _loginController
                                      .confirmPasswordValidator(value, context),
                                  decoration:
                                      AppDecorations.textFieldDecoration(
                                              context)
                                          .copyWith(
                                    hintText: 'Confirm Password',
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(18),
                                      child: SizedBox(
                                        width: 16,
                                        height: 15,
                                        child: SvgPicture.asset(AppAssets.lock,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? AppColors.darkGray
                                                    : AppColors.greyWhite),
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      splashColor: Get.theme.backgroundColor,
                                      color: Get.theme.backgroundColor,
                                      highlightColor: Colors.transparent,
                                      onPressed: () {
                                        _loginController
                                                .isConfirmPasswordHidden.value =
                                            !_loginController
                                                .isConfirmPasswordHidden.value;
                                      },
                                      icon: SvgPicture.asset(
                                          _loginController
                                                  .isConfirmPasswordHidden.value
                                              ? AppAssets.eye
                                              : AppAssets.hideEye,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? AppColors.darkGray
                                              : AppColors.greyWhite),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: showResetPassword
                    ? AppPrimaryButton(
                        child: const Text('NEXT'),
                        onPressed: _loginController.updatePassword,
                        key: _loginController.buttonKey,
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
