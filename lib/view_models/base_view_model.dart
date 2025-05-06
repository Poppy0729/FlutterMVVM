import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_template/models/api_response.dart';

enum LoadingState {
  initial,
  loading,
  loaded,
  onError(error: null);

  final APIResponse? error;
  const LoadingState({this.error});
}

class BaseViewModel extends ChangeNotifier {
  bool isCallApi = false;
  LoadingState status = LoadingState.initial;

  callApi(bool isCall) {
    isCallApi = isCall;
    status = isCall ? LoadingState.loading : LoadingState.loaded;
    notifyListeners();
  }

  apiError(APIResponse error, {Function? confirmCallback}) {
    callApi(false);
    if (kDebugMode) {
      print(error.message);
    }
    status = LoadingState.onError;
    // if (error.statusCode == 401) {
    //   Future.delayed(const Duration(milliseconds: 30)).then((value) =>
    //     NavigationService.shared.navigateTo(PopupTokenExpiredRoute));
    // } else if (error.statusCode == 9999) {
    //   Future.delayed(const Duration(milliseconds: 30)).then((value) =>
    //     NavigationService.shared.navigateTo(PopupNoInternetRoute, arguments: {'error': error, 'confirmCallback': confirmCallback}));
    // } else {
    //   Future.delayed(const Duration(milliseconds: 30)).then((value) =>
    //     NavigationService.shared.navigateTo(PopupInfoRoute, arguments: {'error': error, 'confirmCallback': confirmCallback}));
    // }
    
    notifyListeners();
  }

  bool checkTokenExpired(APIResponse error) {
    if (error.statusCode == 401 || error.statusCode == 9999) {
      apiError(error);
        return true;
    } 
    return false;
  }
}
