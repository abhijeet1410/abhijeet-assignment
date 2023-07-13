import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:assignment_pay/app_configs/app_colors.dart';
import 'package:assignment_pay/global_controllers/app_state_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:assignment_pay/pages/base_page.dart';
import 'package:assignment_pay/utils/local_session_timeout/local_session_timeout.dart';
import '../../app_configs/app_assets.dart';
import 'controllers/dashboard_controller.dart';

class DashboardPage extends BasePage {
  static const routeName = '/';

  const DashboardPage({Key? key}) : super(key: key);

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends BasePageState<DashboardPage>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  late DashboardController _dashboardController;
  late AppStateController _appStateController;
  final sessionStateStream = StreamController<SessionState>();
  var _inactivityTimeout = Duration(seconds: 10);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //authorize()
    _dashboardController = Get.isRegistered<DashboardController>()
        ? Get.find<DashboardController>()
        : Get.put(DashboardController());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      sessionStateStream.add(SessionState.startListening);
    });
    // _appStateController.sessionStateStream.add(SessionState.startListening);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    //_appStateController.sessionConfig.dispose();
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
          () => WillPopScope(
        onWillPop: _dashboardController.onPopScope,
        child: Scaffold(
          key: _key,
          body: _dashboardController.currentPage,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _dashboardController.selectedIndex.value,
            elevation: 0,
            onTap: _dashboardController.onTap,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppAssets.homeVector),
                  label: '',
                  activeIcon: Stack(clipBehavior: Clip.none, children: [
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width / 6 - 30,
                        ),
                        SvgPicture.asset(
                          AppAssets.homeVectorFilled,
                          color: Get.isDarkMode
                              ? AppColors.lightPurple
                              : AppColors.brightPrimary,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.isDarkMode
                                ? AppColors.lightPurple
                                : AppColors.brightPrimary,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: -27,
                        left: Get.width / 6 - 40,
                        child: SvgPicture.asset(
                          AppAssets.bottomIndicator,
                          color: Get.isDarkMode
                              ? AppColors.lightPurple
                              : AppColors.brightPrimary,
                        )),
                  ])),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppAssets.activityVector),
                  label: '',
                  activeIcon: Stack(clipBehavior: Clip.none, children: [
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width / 6 - 30,
                        ),
                        SvgPicture.asset(
                          AppAssets.activityVectorFilled,
                          color: Get.isDarkMode
                              ? AppColors.lightPurple
                              : AppColors.brightPrimary,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Activity",
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.isDarkMode
                                ? AppColors.lightPurple
                                : AppColors.brightPrimary,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: -25,
                        left: Get.width / 6 - 40,
                        child: SvgPicture.asset(
                          AppAssets.bottomIndicator,
                          color: Get.isDarkMode
                              ? AppColors.lightPurple
                              : AppColors.brightPrimary,
                        )),
                  ])),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppAssets.walletVector,
                  ),
                  label: '',
                  activeIcon: Stack(clipBehavior: Clip.none, children: [
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width / 6 - 30,
                        ),
                        SvgPicture.asset(
                          AppAssets.walletVectorFilled,
                          color: Get.isDarkMode
                              ? AppColors.lightPurple
                              : AppColors.brightPrimary,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Wallet",
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.isDarkMode
                                ? AppColors.lightPurple
                                : AppColors.brightPrimary,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: -27,
                        left: Get.width / 6 - 40,
                        child: SvgPicture.asset(
                          AppAssets.bottomIndicator,
                          color: Get.isDarkMode
                              ? AppColors.lightPurple
                              : AppColors.brightPrimary,
                        )),
                  ])),
            ],
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //     currentIndex: _dashboardController.selectedIndex.value,
          //     selectedItemColor: AppColors.brightPrimary,
          //     onTap: _dashboardController.onTap,
          //     type: BottomNavigationBarType.fixed,
          //     items: [
          //       BottomNavigationBarItem(
          //           activeIcon: SvgPicture.asset(
          //             AppAssets.homeVectorFilled,
          //           ),
          //           icon: SvgPicture.asset(AppAssets.homeVector),
          //           label: 'Home'),
          //       BottomNavigationBarItem(
          //           activeIcon: SvgPicture.asset(
          //             AppAssets.activityVector,
          //             color: Get.theme.primaryColor,
          //           ),
          //           icon: SvgPicture.asset(AppAssets.activityVector),
          //           label: 'Activity'),
          //       BottomNavigationBarItem(
          //           activeIcon: SvgPicture.asset(
          //             AppAssets.walletVectorFilled,
          //           ),
          //           icon: SvgPicture.asset(AppAssets.walletVector),
          //           label: 'Wallet'),
          //     ]),
        ),
      ),
    );
  }

// showOverlay(BuildContext context) {
//   OverlayState? overlayState = Overlay.of(context);
//   OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//       child: Container(
//         height: Get.height,
//         width: Get.width,
//         decoration:
//         BoxDecoration(color: Colors.grey.shade100.withOpacity(0.5)),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               DefaultTextStyle(
//                 child: Text('Your VePay app is locked'),
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18,
//                     color: Colors.black),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               DefaultTextStyle(
//                 child: Text(
//                   'Please close the app and open it again\nto unlock',
//                   textAlign: TextAlign.center,
//                 ),
//                 style: TextStyle(fontSize: 14, color: Colors.black),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   });
//   overlayState?.insert(overlayEntry);
// }
//
// authorize() async {
//   if (Platform.isAndroid) {
//     try {
//       await KeyGuardmanager.authStatus;
//     } on PlatformException {
//       showOverlay(context);
//     }
//   } else if (Platform.isIOS) {
//     bool authenticated;
//     try {
//       authenticated = await _localAuthentication.authenticate(
//           localizedReason: "Authenticate for Testing", // message for dialog
//           options: const AuthenticationOptions(
//             stickyAuth: false,
//             biometricOnly: false,
//           ));
//       if (!authenticated) {
//         showOverlay(context);
//         print("Close the app");
//       } else if (authenticated) {
//         print('Success');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//   if (!mounted) return;
// }

// @override
// Widget build(BuildContext context) {
//   final sessionConfig = SessionConfig(
//     invalidateSessionForAppLostFocus: const Duration(seconds: 10),
//     invalidateSessionForUserInactiviity: const Duration(seconds: 10),
//   );
//   sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
//     // stop listening, as user will already be in auth page
//     _appStateController.sessionStateStream.add(SessionState.stopListening);
//     if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
//       log("invalidate session");
//       Get.offAllNamed(LockScreen.routeName);
//     } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
//       log("invalidate app focus");
//       Get.offAllNamed(LockScreen.routeName);
//     }
//   });
//   return SessionTimeoutManager(
//     sessionConfig: sessionConfig,
//     sessionStateStream: _appStateController.sessionStateStream.stream,
//     child: Obx(
//       () => WillPopScope(
//         onWillPop: _dashboardController.onPopScope,
//         child: Scaffold(
//           key: _key,
//           body: _dashboardController.currentPage,
//           bottomNavigationBar: BottomNavigationBar(
//             currentIndex: _dashboardController.selectedIndex.value,
//             elevation: 0,
//             onTap: _dashboardController.onTap,
//             items: [
//               BottomNavigationBarItem(
//                   icon: SvgPicture.asset(AppAssets.homeVector),
//                   label: '',
//                   activeIcon: Stack(clipBehavior: Clip.none, children: [
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: Get.width / 6 - 30,
//                         ),
//                         SvgPicture.asset(
//                           AppAssets.homeVectorFilled,
//                           color: Get.isDarkMode
//                               ? AppColors.lightPurple
//                               : AppColors.brightPrimary,
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Home",
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Get.isDarkMode
//                                 ? AppColors.lightPurple
//                                 : AppColors.brightPrimary,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Positioned(
//                         bottom: -27,
//                         left: Get.width / 6 - 40,
//                         child: SvgPicture.asset(
//                           AppAssets.bottomIndicator,
//                           color: Get.isDarkMode
//                               ? AppColors.lightPurple
//                               : AppColors.brightPrimary,
//                         )),
//                   ])),
//               BottomNavigationBarItem(
//                   icon: SvgPicture.asset(AppAssets.activityVector),
//                   label: '',
//                   activeIcon: Stack(clipBehavior: Clip.none, children: [
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: Get.width / 6 - 30,
//                         ),
//                         SvgPicture.asset(
//                           AppAssets.activityVectorFilled,
//                           color: Get.isDarkMode
//                               ? AppColors.lightPurple
//                               : AppColors.brightPrimary,
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Activity",
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Get.isDarkMode
//                                 ? AppColors.lightPurple
//                                 : AppColors.brightPrimary,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Positioned(
//                         bottom: -25,
//                         left: Get.width / 6 - 40,
//                         child: SvgPicture.asset(
//                           AppAssets.bottomIndicator,
//                           color: Get.isDarkMode
//                               ? AppColors.lightPurple
//                               : AppColors.brightPrimary,
//                         )),
//                   ])),
//               BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     AppAssets.walletVector,
//                   ),
//                   label: '',
//                   activeIcon: Stack(clipBehavior: Clip.none, children: [
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: Get.width / 6 - 30,
//                         ),
//                         SvgPicture.asset(
//                           AppAssets.walletVectorFilled,
//                           color: Get.isDarkMode
//                               ? AppColors.lightPurple
//                               : AppColors.brightPrimary,
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Wallet",
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Get.isDarkMode
//                                 ? AppColors.lightPurple
//                                 : AppColors.brightPrimary,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Positioned(
//                         bottom: -27,
//                         left: Get.width / 6 - 40,
//                         child: SvgPicture.asset(
//                           AppAssets.bottomIndicator,
//                           color: Get.isDarkMode
//                               ? AppColors.lightPurple
//                               : AppColors.brightPrimary,
//                         )),
//                   ])),
//             ],
//           ),
//           // bottomNavigationBar: BottomNavigationBar(
//           //     currentIndex: _dashboardController.selectedIndex.value,
//           //     selectedItemColor: AppColors.brightPrimary,
//           //     onTap: _dashboardController.onTap,
//           //     type: BottomNavigationBarType.fixed,
//           //     items: [
//           //       BottomNavigationBarItem(
//           //           activeIcon: SvgPicture.asset(
//           //             AppAssets.homeVectorFilled,
//           //           ),
//           //           icon: SvgPicture.asset(AppAssets.homeVector),
//           //           label: 'Home'),
//           //       BottomNavigationBarItem(
//           //           activeIcon: SvgPicture.asset(
//           //             AppAssets.activityVector,
//           //             color: Get.theme.primaryColor,
//           //           ),
//           //           icon: SvgPicture.asset(AppAssets.activityVector),
//           //           label: 'Activity'),
//           //       BottomNavigationBarItem(
//           //           activeIcon: SvgPicture.asset(
//           //             AppAssets.walletVectorFilled,
//           //           ),
//           //           icon: SvgPicture.asset(AppAssets.walletVector),
//           //           label: 'Wallet'),
//           //     ]),
//         ),
//       ),
//     ),
//   );
// }
}