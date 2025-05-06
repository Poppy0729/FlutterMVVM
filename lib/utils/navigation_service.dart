import 'package:flutter/material.dart';

class NavigationService {

  static final NavigationService _navigationService = NavigationService();
  static NavigationService get shared => _navigationService;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateReplaceTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  Future<dynamic> resetRoot(String routeName) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  bool goBack() {
    navigatorKey.currentState!.pop();
    return true;
  }
}