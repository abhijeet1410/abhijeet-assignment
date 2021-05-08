import 'package:ausicare_doctor/global_controllers/user_controller.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
  }
}
