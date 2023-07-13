import 'dart:io';
import 'package:assignment_pay/pages/authenticaton/login_email/login_email_page.dart';
import 'package:assignment_pay/utils/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:assignment_pay/pages/my_account/components/my_account_tile.dart';
import 'package:assignment_pay/pages/my_account/components/my_details/pages/my_details_page.dart';
import 'package:assignment_pay/utils/app_auth_helper.dart';
import 'package:assignment_pay/utils/snackbar_helper.dart';
import 'package:assignment_pay/widgets/alert_dialog.dart';
import 'package:assignment_pay/widgets/user_circle_avatar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../app_configs/app_assets.dart';
import '../../../global_controllers/user_controller.dart';
import '../../base_page.dart';

class MyAccountPage extends BasePage {
  static const String routeName = "/MyAccountPage";

  const MyAccountPage({Key? key}) : super(key: key);

  @override
  MyAccountPageState createState() => MyAccountPageState();
}

class MyAccountPageState extends BasePageState<MyAccountPage> {
  late UserController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<UserController>();
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: const AppBackButton(),
      //   backgroundColor: Colors.transparent,
      // ),
      body: _controller.obx((state) => state == null
          ? const SizedBox()
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      // padding: _controller.state!.kyc!.kycVerificationStatus == 1
                      //     ? const EdgeInsets.only(
                      //         left: 16,
                      //         bottom: 16,
                      //         right: 16,
                      //       )
                      //     : const EdgeInsets.all(16),
                      children: [
                        SizedBox(
                          height: 284,
                          child: Stack(children: [
                            SizedBox(
                              width: Get.width,
                              child: SvgPicture.asset(
                                AppAssets.profileBackground,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: SvgPicture.asset(
                                          Platform.isAndroid
                                              ? AppAssets.backArrow
                                              : AppAssets.iosBackArrow,
                                          height: 16,
                                          width: 16,
                                          color: const Color(0xffFFFFFF)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 56,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      UserCircleAvatar(
                                          '${_controller.state!.avatar}',
                                          radius: 45),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        '${_controller.state!.firstName} ${_controller.state!.lastName}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 17,
                                      ),
                                      const Text(
                                        "@user",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(
                                thickness: 1,
                              ),
                              MyAccountTile(AppAssets.profile, 'My Details',
                                  onTap: () =>
                                      Get.toNamed(MyDetailsPage.routeName)),
                              MyAccountTile(AppAssets.bank, 'My Bank Accounts',
                                  onTap: () {}),
                              MyAccountTile(
                                AppAssets.card,
                                'My Cards',
                                onTap: (() {}),
                              ),
                              MyAccountTile(AppAssets.security, 'Security',
                                  onTap: () async {}),
                              MyAccountTile(
                                  AppAssets.settingsVector, 'Settings',
                                  onTap: () {}),
                              MyAccountTile(
                                AppAssets.faq,
                                'Help',
                                onTap: (() {}),
                              ),
                              MyAccountTile(
                                AppAssets.power,
                                'Log out',
                                onTap: () {
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
                                    }
                                  });
                                },
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              MyAccountTile(AppAssets.legal, 'Legals',
                                  onTap: () async {
                                SnackBarHelper.show(
                                    "Privacy Policy Coming Soon");
                              }),
                              MyAccountTile(AppAssets.about, 'About',
                                  onTap: () async {
                                SnackBarHelper.show("About Coming Soon");
                              }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
    );
  }
}
