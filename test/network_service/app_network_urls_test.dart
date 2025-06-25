import 'package:flutter_mvvm_template/constants/app_network_urls.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Test app network urls', () {
    test('Test api endpoint worklist', () async {
      const result = AppNetworkUrls.weather;
      expect(result, '/onecall');
    });
  });
}