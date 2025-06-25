import 'package:flutter_mvvm_template/utils/pprint.dart';
import 'package:flutter_mvvm_template/utils/utilities.dart';
import 'package:flutter_mvvm_template/view_models/base_view_model.dart';
import 'package:flutter_mvvm_template/view_models/repositories/home_repository.dart';
import '../../models/weather.dart';

class HomeViewModel extends BaseViewModel {
  final HomeRepository _homeRepository = HomeRepository.instance;
  Weather? weather;
  String get dayTemp {
    return Utilities.convertTemp(weather?.daily?[0].temp?.day ?? 273);
  }

  String get nightTemp {
    return Utilities.convertTemp(weather?.daily?[0].temp?.night ?? 273);
  }

  fetchWeather() async {
    if (isCallApi) return;
    callApi(true);
    await _homeRepository.callGetWeather().then((value) {
      callApi(false);
      pprint('weather ${value.current?.feelsLike ?? 0}');
      weather = value;
      notifyListeners();
    }).onError((error, stackTrace) {
      // apiError(error as APIResponse);
      pprint(error);
      callApi(false);
    });
  }
}