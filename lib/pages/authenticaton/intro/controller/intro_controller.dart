import 'package:flutter_mobile_template/app_configs/app_assets.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class IntroController extends GetxController {
  RxInt currentIndex = RxInt(0);

  void initController() {
    // currentIndex = );
    super.onInit();
  }

  void disposeController() {
    currentIndex.close();
    super.onClose();
  }

  String get currentIntroAsset => AppAssets.introAssets[currentIndex.value];

  void onPageChange(int value) {
    currentIndex.value = value;
  }
}
