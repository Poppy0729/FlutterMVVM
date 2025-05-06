import 'package:package_info_plus/package_info_plus.dart';
import '../base_view_model.dart';

class ProfileViewModel extends BaseViewModel {
  int value = 0;
  String buildNumber = '1.0.0';

  updateValueMock() {
    value++;
    notifyListeners();
  }

  void prepareSomething() {
    getUserLogin();
  }

  getUserLogin() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    buildNumber = packageInfo.version;
    notifyListeners();
  }

  logout() {
    // TODO: Clean up the shared preferences
    notifyListeners();
  }
}