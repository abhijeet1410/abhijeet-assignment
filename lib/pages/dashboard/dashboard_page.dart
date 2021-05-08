import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/dashboard_controller.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class DashboardPage extends GetView<DashboardController> {
  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
