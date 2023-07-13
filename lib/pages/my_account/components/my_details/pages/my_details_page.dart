import 'dart:io';
import 'package:flutter/material.dart';
import 'package:assignment_pay/app_configs/app_colors.dart';
import 'package:assignment_pay/widgets/app_buttons/app_back_button.dart';
import 'package:assignment_pay/widgets/app_loader.dart';
import 'package:assignment_pay/widgets/user_circle_avatar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../app_configs/app_assets.dart';
import '../../../../../global_controllers/user_controller.dart';
import '../../../../../widgets/photo_chooser.dart';
import '../components/my_details_heading.dart';

class MyDetailsPage extends StatefulWidget {
  static const routeName = "/MyDetailsPage";

  const MyDetailsPage({Key? key}) : super(key: key);

  @override
  State<MyDetailsPage> createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<MyDetailsPage> {
  late UserController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<UserController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const AppBackButton(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _controller.obx((state) => state == null
            ? const SizedBox()
            : ListView(
                padding: const EdgeInsets.only(left: 16),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: UserCircleAvatar('${_controller.state!.avatar}', radius: 45),
                          ),
                          Positioned(
                            right: 2,
                            bottom: 2,
                            child: InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                        const PhotoChooser(
                                          title: 'Crop your avatar',
                                        ),
                                        backgroundColor: Get.isDarkMode
                                            ? AppColors.darkBackground
                                            : AppColors.brightBackground)
                                    .then((value) {
                                  if (value != null && value is File) {
                                  }
                                });
                              },
                              splashColor: Colors.transparent,
                              child: Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xff333333).withOpacity(0.60)),
                                child: Center(
                                    child: SvgPicture.asset(
                                  AppAssets.camera,
                                  width: 16,
                                  height: 16,
                                )),
                              ),
                            ),
                          ),
                          if (_isLoading)
                            const Positioned.fill(
                              child: AppProgress(
                                color: Color(0xffFFDE59),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("@user",
                      textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const MyDetailsHeading('Basic Details'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_controller.state!.firstName! + " " + _controller.state!.lastName!,
                            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                            "Date of birth: ${DateFormat('dd/MM/yyyy').format(_controller.state!.dob!)}",
                            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                            "Phone: +91 ${_controller.state!.phone}",
                            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        thickness: 1,
                      ),
                      MyDetailsHeading(
                          'Address', onTap: () {}),
                    ],
                  )
                ],
              )),
      ),
    );
  }
}
