import 'package:assignment_pay/global_controllers/app_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  late AppStateController _appStateController;
  var previousState;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _appStateController = Get.isRegistered<AppStateController>()
        ? Get.find<AppStateController>()
        : Get.put(AppStateController());
    _appStateController.handleUserInteraction();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      _appStateController.handleUserInteraction();
    } else {
      _appStateController.handleUserInteraction();
    }
    return Listener(
        onPointerCancel: _appStateController.handleUserInteraction,
        onPointerUp: _appStateController.handleUserInteraction,
        onPointerSignal: _appStateController.handleUserInteraction,
        onPointerHover: _appStateController.handleUserInteraction,
        onPointerMove: _appStateController.handleUserInteraction,
        onPointerDown: _appStateController.handleUserInteraction,
        child: body(context));
    // return StreamBuilder<SessionTimeoutState>(
    //     stream: _appStateController.sessionConfig.stream,
    //     builder: (context, snapshot) {
    //       if (previousState != snapshot.data) {
    //         previousState = snapshot.data;
    //         _appStateController.sessionStateStream
    //             .add(SessionState.stopListening);
    //         log("LOGGED");
    //
    //         // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //         //   Get.offAllNamed(LockScreen.routeName);
    //         // });
    //       }
    //       return body(context);
    //     });
  }

  Widget body(BuildContext context);
}
