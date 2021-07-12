import 'package:get/get.dart';
import 'package:god_flutter/pages/dashboard/controllers/dashboard_controller.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}
