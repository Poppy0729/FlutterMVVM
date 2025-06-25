import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_template/constants/app_network_urls.dart';
import 'package:flutter_mvvm_template/main.dart';
import 'package:flutter_mvvm_template/models/api_response.dart';
import 'package:flutter_mvvm_template/models/app_config.dart';
import 'package:flutter_mvvm_template/network_service/base_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'base_api_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Connectivity>()])
void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  late BaseAPIService newBaseAPIService;
  late MockConnectivity mockConnectivity;

  const successMessage = {'message': 'Success'};
  const errorMessage = {'message': 'error'};
  const baseUrl = 'https://api.github.com';
  const endpoint = AppNetworkUrls.weather;
  final body = {"name": "morpheus", "job": "leader"};
  final headers = {"Content-type": "application/json; charset=UTF-8"};

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    WidgetsFlutterBinding.ensureInitialized();
    appConfig = await AppConfig.forEnvironment('dev');
    dio.httpClientAdapter = dioAdapter;
    mockConnectivity = MockConnectivity();

    newBaseAPIService = BaseAPIService(
        baseUrl: baseUrl,
        endpoint: endpoint,
        dio: dio,
        connectivity: mockConnectivity);
    // FlutterSecureStorage.setMockInitialValues({});
  });

  group('Test initial base api service', () {
    test('Should be a subclass of BaseAPIService', () {
      final service = BaseAPIService(
          baseUrl: baseUrl,
          endpoint: endpoint,
          dio: dio,
          connectivity: mockConnectivity);

      expect(service.baseUrl, baseUrl);
      expect(service.endpoint, endpoint);
    });
  });

  group('Test check internet connection', () {
    test('When connect internet should return true', () async {
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) => Future.value([ConnectivityResult.wifi]));
      final response = await newBaseAPIService.isConnectInternet();
      expect(response, true);
    });

    test('When not connect internet should be return false', () async {
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) => Future.value([ConnectivityResult.none]));
      final response = await newBaseAPIService.isConnectInternet();
      expect(response, false);
    });
  });

  group('Test Get method', () {
      test('when Client response was 200 and had valid data', () async {
        // Arrange
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) => Future.value([ConnectivityResult.wifi]));
        dioAdapter.onGet(
          '$baseUrl$endpoint',
          (request) {
            return request.reply(200, successMessage);
          },
          data: null,
        );
  
        // Act
        final response = await newBaseAPIService.callGetAPI();
  
        // Assert
        expect(response.statusCode, equals(200));
        expect(response, isA<APIResponse>());
        expect(response.object, successMessage);
        expect(response.isSuccess, true);
      });
  
      test('when Client response was serverException and had invalid data', () async {
        // Arrange
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) => Future.value([ConnectivityResult.wifi]));
        dioAdapter.onGet(
          '$baseUrl$endpoint',
          (request) {
            return request.reply(400, errorMessage);
          },
          data: null,
        );
  
        // Act
        final response = await newBaseAPIService.callGetAPI();
  
        // Assert
        expect(response.statusCode, isNot(200));
        expect(response, isA<APIResponse>());
        expect(response.isSuccess, false);
      });
  
      test('when Client response was not connect internet should return error', () async {
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) => Future.value([ConnectivityResult.none]));
        
        // Act
        final response = await newBaseAPIService.callGetAPI();
  
        // Assert
        expect(response.statusCode, isNot(200));
        expect(response, isA<APIResponse>());
        expect(response.isSuccess, false);
      });
    });

    group('Test Post method', () { 
        test('when Client response was 200 and had valid data', () async {
          // Arrange
          when(mockConnectivity.checkConnectivity()).thenAnswer((_) => Future.value([ConnectivityResult.wifi]));
          dioAdapter.onPost(
            '$baseUrl$endpoint',
            (request) {
              return request.reply(200, successMessage);
            },
            data: body,
            headers: headers,
          );
    
          // Act
          final response = await newBaseAPIService.callPostAPI(body: body, myHeaders: headers);
    
          // Assert
          expect(response.statusCode, equals(200));
          expect(response, isA<APIResponse>());
          expect(response.object, successMessage);
          expect(response.isSuccess, true);
        });
    
        test('when Client response was serverException and had invalid data', () async {
          when(mockConnectivity.checkConnectivity()).thenAnswer((_) => Future.value([ConnectivityResult.wifi]));
          dioAdapter.onPost('$baseUrl$endpoint', (request) {
            return request.reply(503, errorMessage);
          },
            data: body,
            headers: headers,
          );
    
          // Act
          final response = await newBaseAPIService.callPostAPI(body: body, myHeaders: headers);
    
          // Assert
          expect(response.statusCode, isNot(200));
          expect(response, isA<APIResponse>());
          expect(response.isSuccess, false);
        });
    
        test('when Client response was not connect internet should return error', () async {
          when(mockConnectivity.checkConnectivity()).thenAnswer((_) => Future.value([ConnectivityResult.none]));
          
          // Act
          final response = await newBaseAPIService.callPostAPI(body: body, myHeaders: headers);
    
          // Assert
          expect(response.statusCode, isNot(200));
          expect(response, isA<APIResponse>());
          expect(response.isSuccess, false);
        });
      });

  group('Test Delete method', () {
      test('when Client response was 200 and had valid data', () async {
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) => Future.value([ConnectivityResult.wifi]));
        dioAdapter.onDelete('$baseUrl$endpoint', (request) {
          return request.reply(200, successMessage);
        }, data: body);
  
        // Act
        final response = await newBaseAPIService.callDeleteAPI(body: body);
  
        // Assert
        expect(response.statusCode, equals(200));
        expect(response, isA<APIResponse>());
        expect(response.isSuccess, true);
      });
  
      test('when Client response was serverException and had invalid data', () async {
        // Arrange
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) => Future.value([ConnectivityResult.wifi]));
        dioAdapter.onDelete('$baseUrl$endpoint', (request) {
          return request.reply(400, errorMessage);
        }, data: body);
  
        // Act
        final response = await newBaseAPIService.callDeleteAPI(body: body);
  
        // Assert
        expect(response, isA<APIResponse>());
        expect(response.statusCode, isNot(200));
        expect(response.isSuccess, false);
      });
  
      test('when Client response was not connect internet should return error', () async {
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) => Future.value([ConnectivityResult.none]));
        
        // Act
        final response = await newBaseAPIService.callDeleteAPI(body: body);
  
        // Assert
        expect(response.statusCode, isNot(200));
        expect(response, isA<APIResponse>());
        expect(response.isSuccess, false);
      });
    });

  group('Test Put method', () {
      test('when Client response was 200 and had valid data', () async {
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) => Future.value([ConnectivityResult.wifi]));
        dioAdapter.onPut('$baseUrl$endpoint', (request) {
          return request.reply(200, successMessage);
        }, data: body);
  
        // Act
        final response =
            await newBaseAPIService.callPutAPI(body: body, myHeaders: headers);
  
        // Assert
        expect(response.statusCode, equals(200));
        expect(response, isA<APIResponse>());
        expect(response.object, successMessage);
        expect(response.isSuccess, true);
      });
  
      test('when Client response was serverException and had invalid data', () async {
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) => Future.value([ConnectivityResult.wifi]));
        dioAdapter.onPut('$baseUrl$endpoint', (request) {
          return request.reply(400, errorMessage);
        }, data: body);
  
        // Act
        final response =
            await newBaseAPIService.callPutAPI(body: body, myHeaders: headers);
  
        // Assert
        expect(response.statusCode, isNot(200));
        expect(response, isA<APIResponse>());
        expect(response.isSuccess, false);
      });
  
      test('when Client response was not connect internet should return error', () async {
        when(mockConnectivity.checkConnectivity()).thenAnswer((_) => Future.value([ConnectivityResult.none]));
  
        // Act
        final response = await newBaseAPIService.callPutAPI(body: body, myHeaders: headers);
  
        // Assert
        expect(response.statusCode, isNot(200));
        expect(response, isA<APIResponse>());
        expect(response.isSuccess, false);
      });
    });
}
