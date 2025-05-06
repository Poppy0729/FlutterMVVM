import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mvvm_template/main.dart';
import 'package:flutter_mvvm_template/utils/pprint.dart';
import 'package:flutter_mvvm_template/views/undefined/undefined_screen.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import 'package:flutter_mvvm_template/utils/router.dart' as router;
import 'package:flutter_mvvm_template/constants/router_path_constants.dart' as routes;
import '../utils/navigation_service.dart';
import '../view_models/providers/profile_view_model.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  
  Future<void> secureOn() async {
    if (!appConfig.flavor.contains('dev')) {
      // await ScreenProtector.protectDataLeakageOn();
      // await ScreenProtector.preventScreenshotOn();
    }
  }

  Future<void> secureOff() async {
    if (!appConfig.flavor.contains('dev')) {
      // await ScreenProtector.protectDataLeakageOff();
      // await ScreenProtector.preventScreenshotOff();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    secureOn();
    _checkScreenRecording();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    secureOff();
    _removeListenerPreventScreenshot();
    super.dispose();
  }

  void _checkScreenRecording() async {

  }

  void _removeListenerPreventScreenshot() async {
    // ScreenProtector.removeListener();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    pprint('state change ${state.name}');
    switch (state) {
      case AppLifecycleState.resumed:
        checkSessionExpired();
        // await AppUtils().checkJailbreak();
        break;
      case AppLifecycleState.hidden:
        //secureOn();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => checkSessionExpired(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ], 
        child: MaterialApp(
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationService.shared.navigatorKey,
          onGenerateRoute: router.onGenerateRoute,
          initialRoute: routes.SplashViewRoute,
          onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => UndefinedScreen(
            name: settings.name ?? 'Undefined',
          )),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
         ],
         supportedLocales: const [
            Locale('th'),
         ],
        )
      ),
    );
  }

  // Check Expired
  checkSessionExpired() async {
    // var expiredTimeStr = await SharedPrefs.shared.getExpiredTime();
    // if (expiredTimeStr.isEmpty) { return; }

    // DateTime dateTime = DateTime.now();

    // DateTime expiredTime = DateTime.parse(expiredTimeStr);
    // if (expiredTime.compareTo(dateTime) < 0) {
    //   logout();
    // } else {
    //   updateSessionExpired();
    // }
  }

  updateSessionExpired() async {
    // DateTime dateTime = DateTime.now();
    // final expTime = dateTime.add(const Duration(hours: 1));
    // SharedPrefs.shared.setExpiredTime(expTime.toString());
  }

  logout() {
    // SharedPrefs.shared.removeValues();
    // NavigationService.shared.gotoLogin('', PinState.login, isReset: true);
  }
}