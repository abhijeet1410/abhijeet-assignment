import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:god_flutter/app_configs/app_assets.dart';
import 'package:god_flutter/app_configs/app_colors.dart';
import 'package:god_flutter/app_configs/app_decorations.dart';
import 'package:god_flutter/pages/authenticaton/controllers/login_controller.dart';
import 'package:god_flutter/pages/authenticaton/pages/login/login_animator.dart';
import 'package:god_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:god_flutter/widgets/app_buttons/app_outline_button.dart';
import 'package:god_flutter/widgets/app_buttons/app_primary_button.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late LoginController _loginController;
  late AnimationController _ac1, _ac2;
  VelocityTracker _vt = VelocityTracker.withKind(PointerDeviceKind.stylus);
  late LoginAnimator animator;

  @override
  void initState() {
    super.initState();
    _loginController = LoginController();
    _loginController.onInit();

    _ac1 = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0.0,
        upperBound: 1.0);
    _ac2 = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 700),
        lowerBound: 0.0,
        upperBound: 1.0);
    animator = LoginAnimator(_ac1, _ac2);
  }

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  Widget socialSignInButton(String text, String icon, VoidCallback onPressed) =>
      AppOutlineButton(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            children: [
              SvgPicture.asset(icon),
              Expanded(child: Center(child: Text(text))),
            ],
          ),
          onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _loginController.formKey,
        autovalidateMode: _loginController.autoValidateMode.value,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBackButton(
                      padding: const EdgeInsets.all(16),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                      child: Text(
                        'Register or Login',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                      child: Text(
                        'Register or Login to view orders, tests & consult doctors.',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff929292)),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedBuilder(
                animation: _ac2,
                builder: (context, child) {
                  return Positioned(
                      left: 16,
                      right: 16,
                      top: animator.vectorTranslation.value,
                      child: Opacity(
                        opacity: animator.vectorOpacity.value,
                        child: child,
                      ));
                },
                child: Center(
                  child: SvgPicture.asset(AppAssets.loginVector),
                ),
              ),
              AnimatedBuilder(
                animation: _ac2,
                builder: (context, child) {
                  return Positioned(
                      left: 16,
                      right: 16,
                      top: animator.phoneSignInButtonTranslation.value,
                      child: Opacity(
                        opacity: animator.phoneSignInButtonOpacity.value,
                        child: child,
                      ));
                },
                child: Center(
                  child: socialSignInButton(
                      'Sign in with Phone', AppAssets.phone, _onTapToggle),
                ),
              ),
              Positioned(
                  left: 16,
                  right: 16,
                  top: size.height / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Mobile Number',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (v) =>
                            _loginController.loginPhoneNumber,
                        onSaved: _loginController.onPhoneSaved,
                        validator: (v) => _loginController.phoneValidator(v,
                            context: context),
                        decoration: AppDecorations.textFieldDecoration(context)
                            .copyWith(
                                hintText: 'xxxxxxxxxx',
                                prefixIconConstraints:
                                    BoxConstraints.tightFor(width: 54),
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 12),
                                      child: Text('+91'),
                                    ),
                                    Container(
                                        height: 32,
                                        width: 1,
                                        color: AppColors.borderColor)
                                  ],
                                )),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 18),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: theme.textTheme.bodyText2,
                            children: [
                              TextSpan(
                                  text: '*By continuing, you agree to our',
                                  style: TextStyle(color: Colors.grey)),
                              TextSpan(
                                  text: ' Terms & Conditions',
                                  style: TextStyle(color: theme.primaryColor)),
                            ],
                          )),
                      SizedBox(height: 32),
                      Center(
                        child: AppPrimaryButton(
                          key: _loginController.buttonKey,
                          child: Text('Continue'),
                          width: size.width,
                          onPressed: _loginController.loginPhoneNumber,
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  )),
              AnimatedBuilder(
                animation: _ac1,
                builder: (context, child) {
                  return Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: animator.bottomSheetTranslation.value,
                      child: Listener(
                          onPointerDown: (PointerDownEvent p) =>
                              _vt.addPosition(p.timeStamp, p.position),
                          onPointerMove: (PointerMoveEvent p) {
                            _vt.addPosition(p.timeStamp,
                                p.position); // add current position for velocity tracking
                            _onGestureSlide(p.delta.dy);
                          },
                          behavior: HitTestBehavior.translucent,
                          onPointerUp: (PointerUpEvent p) =>
                              _onGestureEnd(_vt.getVelocity()),
                          child: child));
                },
                child: ColoredBox(
                  color: theme.backgroundColor,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 22,
                        child: Container(
                          height: 84,
                          width: double.infinity,
                          child: TextButton(
                            onPressed: _onTapToggle,
                            style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 26, 0, 18)),
                            child: Text('Other login methods'),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 22,
                          child: Divider(
                            color: Colors.grey,
                            height: 0,
                          )),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Center(
                          child: GestureDetector(
                            onTap: _onTapToggle,
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xffDDEDFF),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: AnimatedBuilder(
                                  animation: _ac1,
                                  builder: (context, child) {
                                    return Icon(
                                        _ac1.value <= 0.5
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: theme.primaryColor);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onGestureSlide(double dy) {
    _ac1.value -= dy / (Get.height / 1.6 - 84);
    _ac2.value -= dy / (Get.height / 1.6 - 84);
    setState(() {});
  }

  void _onGestureEnd(Velocity v) {
    double minFlingVelocity = 365.0;
    if (_ac1.isAnimating) return;
    double visualVelocity = -v.pixelsPerSecond.dy / ((Get.height / 1.6) - 84);
    double d2Close = _ac1.value;
    double d2Open = 1 - _ac1.value;
    double d2Snap = (2 - _ac1.value).abs();
    double minDistance = min(d2Close, min(d2Snap, d2Open));

    if (v.pixelsPerSecond.dy.abs() >= minFlingVelocity) {
      _ac1.fling(velocity: visualVelocity);
      _ac2.fling(velocity: visualVelocity);
      return;
    }
    if (minDistance == d2Close) {
      _close();
    } else if (minDistance == d2Snap) {
      _flingPanelToPosition(1.5, visualVelocity);
    } else {
      _open();
    }
  }

  void _flingPanelToPosition(double targetPos, double velocity) {
    final Simulation simulation = SpringSimulation(
        SpringDescription.withDampingRatio(
          mass: 1.0,
          stiffness: 500.0,
          ratio: 1.0,
        ),
        _ac1.value,
        targetPos,
        velocity);

    _ac1.animateWith(simulation);
  }

  void _onTapToggle() {
    if (_ac1.value < 0.5) {
      _ac1.forward();
      _ac2.forward();
    } else {
      _ac1.reverse();
      _ac2.reverse();
    }
  }

  void _close() {
    _ac1.fling(velocity: -1.0);
    _ac2.fling(velocity: -1.0);
  }

  void _open() {
    _ac1.fling(velocity: 1.0);
    _ac2.fling(velocity: 1.0);
  }
}
