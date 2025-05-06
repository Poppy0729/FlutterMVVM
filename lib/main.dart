import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm_template/models/app_config.dart';
import 'package:flutter_mvvm_template/utils/pprint.dart';
import 'package:flutter_mvvm_template/views/app.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

late AppConfig appConfig;
var isE2E = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setAppConfig();
  Intl.defaultLocale = "th";

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const App());
}

Future<void> setAppConfig() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String packageName = packageInfo.packageName;
  if (kDebugMode) {
    print(packageName);
  }

  // Get config from environment
  if (packageName.contains('qa')) {
    appConfig = await AppConfig.forEnvironment('qa');
  } else if (packageName.contains('prod')) {
    appConfig = await AppConfig.forEnvironment('prod');
  } else {
    appConfig = await AppConfig.forEnvironment('dev');
  }

  const isE2EValue = String.fromEnvironment('IS_E2E', defaultValue: 'False');
  isE2E = isE2EValue.contains('True');

  if (kDebugMode) {
    print(appConfig.flavor);
    pprint(isE2E);
  }
}