import 'package:flutter_mvvm_template/constants/app_network_urls.dart';
import 'package:flutter_mvvm_template/main.dart';
import 'package:flutter_mvvm_template/models/api_response.dart';
import 'package:flutter_mvvm_template/models/weather.dart';

import '../../network_service/base_api_service.dart';

class HomeRepository {
  // Generate Instance
  static final HomeRepository homeRepository = HomeRepository();
  
  static HomeRepository get instance => homeRepository;

  Future<Weather> callGetWeather() async {
    BaseAPIService request = BaseAPIService(
      baseUrl: appConfig.baseApiUrl, 
      endpoint: AppNetworkUrls.weather
    );

    APIResponse response = await request.callGetAPI(
      parameters: {
        'lat': '13.736717',
        'lon': '100.523186',
        'exclude': 'minutely',
        'appid': appConfig.apiKey
      }
    );
    if (response.isSuccess) {
      final json = response.object;
      Weather weather = Weather.fromJson(json);
      return weather;
    } else {
      return Future.error(response);
    }
  }
}