import 'dart:convert';
import 'package:flutter/services.dart';

class AppConfig {
  final String baseApiUrl;
  final String flavor;
  final String? appPrefix;

  AppConfig({
    required this.baseApiUrl,
    required this.flavor,
    this.appPrefix
  });

  static Future<AppConfig> forEnvironment(String env) async {
    // set default to dev if nothing was passed
    env = env;

    // load the json file
    final contents = await rootBundle.loadString(
      'assets/config/$env.json',
    );

    // decode our json
    final json = jsonDecode(contents);

    // convert our JSON into an instance of our AppConfig class
    return AppConfig(
      baseApiUrl: json['BASE_API_URL'], 
      flavor: json['FLAVOR'], 
      appPrefix: json['APP_PREFIX']
    );
  }
}