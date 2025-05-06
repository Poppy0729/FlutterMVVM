import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/views/splash/splash_screen.dart';
import '../constants/router_path_constants.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  if (settings.name == null) {
    return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
  switch (settings.name) {
    case SplashViewRoute:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    // case HomeViewRoute:
    //   return CupertinoPageRoute(builder: (context) => MainTabbar(selectedIndex: 0,));
    case LoginViewRoute:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case RegisterViewRoute:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    default:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
}