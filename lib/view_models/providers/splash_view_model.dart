import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {

  BuildContext? context;

  SplashViewModel() {
    onInit();
  }

  onInit() async {
    await Future.delayed(const Duration(seconds: 1),() {
      // if (mobile.isEmpty) {
      //   NavigationService.shared.navigateReplaceTo(RegisterRoute);
      // } else {
      //   NavigationService.shared.gotoLogin(mobile, PinState.login, isReset: true);
      // }
    });
  }
}