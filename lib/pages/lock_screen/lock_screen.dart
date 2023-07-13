import 'dart:io';
import 'dart:ui';
import 'package:assignment_pay/pages/authenticaton/login_email/login_email_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:key_guardmanager/key_guardmanager.dart';
import 'package:local_auth/local_auth.dart';
import 'package:assignment_pay/utils/app_auth_helper.dart';
import 'package:assignment_pay/utils/shared_preference_helper.dart';
import '../../app_configs/app_assets.dart';
import '../../app_configs/app_colors.dart';
import '../../app_configs/app_decorations.dart';
import '../../app_configs/app_validators.dart';
import '../../app_configs/environment.dart';
import '../../widgets/alert_dialog.dart';
import '../../widgets/app_buttons/app_primary_button.dart';
import 'controller/lock_screen_controller.dart';

class LockScreen extends StatefulWidget {
  static const routeName = '/LockScreen';

  const LockScreen({Key? key}) : super(key: key);

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  OverlayState? _overlayState;
  OverlayEntry? _overlayEntry;
  late LockScreenController _lockScreenController;
  TextEditingController? _emailController;

  @override
  void initState() {
    super.initState();
    _lockScreenController = LockScreenController();
    _lockScreenController.onInit();
    _emailController = TextEditingController();
    _emailController!.text = SharedPreferenceHelper.user!.user!.email!;
    authorize();
  }

  @override
  void dispose() {
    _lockScreenController.dispose();
    _emailController!.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   //authorize();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 54),
                        Text(
                          "Hey ${SharedPreferenceHelper.user!.user!.firstName}!",
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Please authenticate yourself to access the app by entering the password or verifying with biometrics",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 40),
                        Obx(
                          () => Form(
                            key: _lockScreenController.formKey,
                            autovalidateMode:
                                _lockScreenController.autoValidateMode.value,
                            child: Column(
                              children: [
                                // TextFormField(
                                //   textInputAction: TextInputAction.next,
                                //   controller: _emailController,
                                //   keyboardType: TextInputType.emailAddress,
                                //   enabled: false,
                                //   decoration: AppDecorations
                                //           .textFieldDecoration(context)
                                //       .copyWith(
                                //           hintText: 'Enter email ID',
                                //           prefixIcon: Padding(
                                //             padding: const EdgeInsets.all(18),
                                //             child: SvgPicture.asset(
                                //                 AppAssets.email,
                                //                 color: Theme.of(context)
                                //                             .brightness ==
                                //                         Brightness.light
                                //                     ? AppColors.darkGray
                                //                     : AppColors.greyWhite),
                                //           )),
                                // ),
                                // const SizedBox(height: 24),
                                TextFormField(
                                  obscureText: _lockScreenController
                                      .isPasswordHidden.value,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  onSaved:
                                      _lockScreenController.onPasswordSaved,
                                  validator: (value) =>
                                      AppFormValidators.validateEmpty(
                                          value, context),
                                  decoration: AppDecorations
                                          .textFieldDecoration(context)
                                      .copyWith(
                                          hintText: 'Enter Password',
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(18),
                                            child: SizedBox(
                                              width: 16,
                                              height: 15,
                                              child: SvgPicture.asset(
                                                  AppAssets.lock,
                                                  fit: BoxFit.fill,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? AppColors.darkGray
                                                      : AppColors.greyWhite),
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                            splashColor:
                                                Get.theme.backgroundColor,
                                            onPressed: () {
                                              _lockScreenController
                                                  .updateObscure();
                                            },
                                            icon: SvgPicture.asset(
                                                _lockScreenController
                                                        .isPasswordHidden.value
                                                    ? AppAssets.eye
                                                    : AppAssets.hideEye,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? AppColors.darkGray
                                                    : AppColors.greyWhite),
                                          )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: AppPrimaryButton(
                            child: const Text('AUTHENTICATE'),
                            onPressed: _lockScreenController.onLogin,
                            key: _lockScreenController.buttonKey,
                          ),
                        ),
                        const SizedBox(height: 24),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      'Not ${SharedPreferenceHelper.user!.user!.firstName} ${SharedPreferenceHelper.user!.user!.lastName}? ',
                                  style: TextStyle(
                                    fontFamily: Environment.fontFamily,
                                    fontSize: 16,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AppColors.lightBlack
                                        : Colors.white,
                                    fontWeight: FontWeight.w400,
                                  )),
                              TextSpan(
                                  text: 'LOGOUT',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      showAppAlertDialog(
                                              title: 'Logout?',
                                              description:
                                                  'Are you sure, you want to logout?',
                                              negativeText: 'No',
                                              positiveText: 'Yes')
                                          .then((value) {
                                        if (value!) {
                                          //SharedPreferenceHelper.clear();
                                          Get.offAllNamed(LoginEmailPage.routeName);
;                                        }
                                      });
                                    },
                                  style: TextStyle(
                                    fontFamily: Environment.fontFamily,
                                    fontSize: 16,
                                    color: Get.theme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//
// showOverlay(BuildContext context) {
//   _overlayState = Overlay.of(context);
//   _overlayEntry = OverlayEntry(builder: (context) {
//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//       child: Container(
//         height: Get.height,
//         width: Get.width,
//         decoration:
//             BoxDecoration(color: Colors.grey.shade100.withOpacity(0.5)),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const DefaultTextStyle(
//                 child: Text('Your VePay app is locked'),
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18,
//                     color: Colors.black),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const DefaultTextStyle(
//                 child: Text(
//                   'Please close the app and open it again\nto unlock or Tap on the button below to resume the app',
//                   textAlign: TextAlign.center,
//                 ),
//                 style: TextStyle(fontSize: 14, color: Colors.black),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   await authorize();
//                   _overlayEntry!.remove();
//                 },
//                 child: const Text("CLICK HERE TO RESUME THE APP"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   });
//   _overlayState!.insert(_overlayEntry!);
// }
//
  authorize({bool isDouble = false}) async {
    if (Platform.isAndroid) {
      try {
        await KeyGuardmanager.authStatus;
        _lockScreenController.onRefreshAccessToken();
      } on PlatformException {}
    } else if (Platform.isIOS) {
      bool authenticated;
      try {
        authenticated = await _localAuthentication.authenticate(
            localizedReason: "Authenticate for Testing", // message for dialog
            options: const AuthenticationOptions(
              stickyAuth: false,
              biometricOnly: false,
            ));
        if (!authenticated) {
          print("Close the app");
        } else if (authenticated) {
          _lockScreenController.onRefreshAccessToken();
        }
      } catch (e) {
        print(e);
      }
    }
    if (!mounted) return;
  }
}
