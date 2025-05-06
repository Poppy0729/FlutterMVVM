import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/constants/router_path_constants.dart';
import 'package:flutter_mvvm_template/utils/navigation_service.dart';

class SplashViewModel extends ChangeNotifier {

  BuildContext? context;

  SplashViewModel() {
    onInit();
  }

  onInit() async {
    await Future.delayed(const Duration(seconds: 1),() {
      NavigationService.shared.navigateReplaceTo(HomeViewRoute);
      // if (mobile.isEmpty) {
      //   NavigationService.shared.navigateReplaceTo(RegisterRoute);
      // } else {
      //   NavigationService.shared.gotoLogin(mobile, PinState.login, isReset: true);
      // }
    });
  }
}