import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/pages/dashboard/controllers/profile_controller.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_button.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _profileController = ProfileController();
  @override
  void initState() {
    _profileController.onInit();
    super.initState();
  }

  @override
  void dispose() {
    _profileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(ProfilePage.routeName);
        },
      ),
      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('${_profileController.count}')),
            SizedBox(height: 12),
            AppPrimaryButton(
                child: Text('Increment'),
                onPressed: _profileController.increment),
            SizedBox(height: 12),
            AppOutlineButton(
                child: Text('Decrement'),
                onPressed: _profileController.decrement),
          ],
        ),
      ),
    );
  }
}
