import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/data_models/user.dart';
import 'package:flutter_mobile_template/global_controllers/user_controller.dart';
import 'package:flutter_mobile_template/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      body: userController.obx(
        (state) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text('${state?.name}'),
              subtitle: Text('${state?.email}'),
            ),
            AppPrimaryButton(
                child: Text('Update user'),
                onPressed: () {
                  userController.updateUser(UserDatum(
                      id: '12423', name: 'Kumar', email: 'sk@gmail.com'));
                }),
          ],
        ),
      ),
    );
  }
}
