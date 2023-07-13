import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
}

abstract class BasePageState<T extends BasePage> extends State<T> {
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
  }

  @override
  Widget build(BuildContext context) {
    return body(context);
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
