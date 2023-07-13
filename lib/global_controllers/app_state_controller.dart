import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import '../pages/lock_screen/lock_screen.dart';

class AppStateController extends GetxController {
  // var sessionStateStream = StreamController<SessionState>.broadcast();
  // var sessionConfig = SessionConfig(
  //   invalidateSessionForAppLostFocus: const Duration(seconds: 10),
  //   invalidateSessionForUserInactiviity: const Duration(seconds: 10),
  // );

  Timer? _timer;
  int timerCounter = 240000000000;
  final int _debounceTime = 700;
  Timer? _debounce;

  void initializeTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (timerCounter < 1) {
          _logOutUser();
        } else {
          timerCounter -= 1;
        }
      },
    );
  }

  void _logOutUser() {
    // Log out the user if they're logged in, then cancel the timer.
    // You'll have to make sure to cancel the timer if the user manually logs out
    //   and to call _initializeTimer once the user logs in
    //log("Called");
    _timer!.cancel();
    Get.offAllNamed(LockScreen.routeName);
  }

  // You'll probably want to wrap this function in a debounce
  void handleUserInteraction([_]) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: _debounceTime), () {
      if (_timer != null) {
        if (!_timer!.isActive) {
          // This means the user has been logged out
          return;
        }
        _timer!.cancel();
        initializeTimer();
      } else {
        initializeTimer();
      }
    });
  }
}
