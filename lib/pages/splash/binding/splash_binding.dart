import 'package:get/get.dart';
import 'package:pro_health/global_controllers/user_controller.dart';

///
/// Created by Kumar Sunil from Boiler plate
///

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
  }
}
