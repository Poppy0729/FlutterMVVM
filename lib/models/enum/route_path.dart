enum RoutePath {
  splashRoute,
  loginRoute,
  registerRoute,
  homeRoute;

  String get path {
    switch (this) {
      case RoutePath.splashRoute:
        return '/splash';
      case RoutePath.loginRoute:
        return '/login';
      case RoutePath.registerRoute:
        return '/register';
      case RoutePath.homeRoute:
        return '/home';
      default:
        return '/';
    }
  }
}