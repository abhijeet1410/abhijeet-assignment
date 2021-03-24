import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class ProfileController extends GetxController {
  late RxInt _count;

  int get count => _count.value;

  @override
  void onInit() {
    super.onInit();
    _count = RxInt(0);
  }

  @override
  void dispose() {
    _count.close();
    super.dispose();
  }

  void increment() {
    _count.value++;
  }

  void decrement() {
    _count.value--;
  }
}
