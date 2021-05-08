import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class LoginAnimator {
  final AnimationController controller1, controller2;

  final Animation<double> vectorTranslation;
  final Animation<double> vectorOpacity;

  final Animation<double> phoneSignInButtonOpacity;
  final Animation<double> phoneSignInButtonTranslation;

  final Animation<double> bottomSheetTranslation;

  LoginAnimator(this.controller1, this.controller2)
      : this.bottomSheetTranslation =
            Tween(begin: 104.0, end: (Get.height / 1.6 - 84) + 84).animate(
          CurvedAnimation(
            parent: controller1,
            curve: Interval(0, 1, curve: Curves.ease),
          ),
        ),
        this.vectorTranslation = Tween(begin: Get.height / 5, end: 0.0).animate(
          CurvedAnimation(
            parent: controller2,
            curve: Interval(
              0,
              1,
              curve: Curves.easeIn,
            ),
          ),
        ),
        this.vectorOpacity = Tween(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(
            parent: controller2,
            curve: Interval(
              0.250,
              0.600,
              curve: Curves.ease,
            ),
          ),
        ),
        this.phoneSignInButtonTranslation =
            Tween(begin: Get.height / 3.0, end: Get.height / 4.7).animate(
          CurvedAnimation(
            parent: controller2,
            curve: Interval(
              0.300,
              1,
              curve: Curves.fastLinearToSlowEaseIn,
            ),
          ),
        ),
        this.phoneSignInButtonOpacity = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller2,
            curve: Interval(
              0.300,
              1,
              curve: Curves.ease,
            ),
          ),
        );
}
