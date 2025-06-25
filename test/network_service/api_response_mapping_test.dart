import 'package:dio/dio.dart';
import 'package:flutter_mvvm_template/models/api_response.dart';
import 'package:flutter_mvvm_template/network_service/api_response_mapping.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const successMessage = "{\"message\": \"Success\"}";
  const baseUrl = 'https://api.github.com';
  const endpoint = '/users';

  ApiResponseMapping mapping = ApiResponseMapping();

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Test mapping response success', () {
    test('When client response was success status 200', () async {
      Response<dynamic> response = Response(
          statusCode: 200,
          data: successMessage,
          requestOptions: RequestOptions(path: endpoint, baseUrl: baseUrl));

      // Act
      final responseModel = mapping.returnSuccessResponse(response);

      // Assert
      expect(responseModel.statusCode, 200);
      expect(responseModel, isA<APIResponse>());
      expect(responseModel.isSuccess, true);
      expect(responseModel.object, {'message': 'Success'});
    });

    test('when map response was success status 200 error', () async {
      Response<dynamic> response = Response(
          statusCode: 200,
          data: "successMessage",
          requestOptions: RequestOptions(path: endpoint, baseUrl: baseUrl));

      // Act
      final responseModel = mapping.returnSuccessResponse(response);

      // Assert
      expect(responseModel.statusCode, 200);
      expect(responseModel, isA<APIResponse>());
      expect(responseModel.isSuccess, true);
      expect(responseModel.object, "successMessage");
    });
  });

  group('Test map response DioException error', () {
    test('when Client response was serverException and had invalid data',
        () async {
      DioException error = DioException(
          requestOptions: RequestOptions(path: endpoint, baseUrl: baseUrl),
          message: 'error');

      // Act
      final responseModel = mapping.returnErrorResponse(error);

      // Assert
      expect(responseModel.statusCode, isNot(200));
      expect(responseModel, isA<APIResponse>());
      expect(responseModel.isSuccess, false);
      expect(responseModel.message, 'error');
    });
  });

  group('Test map code error from api', () {
    test('when Client response was serverException and had code data',
        () async {
      final json = {
        'code': 'E100',
      };

      final result = mapping.mapCodeError(json);

      expect(result, 'E100');
    });
  });

  group('Test default error response', () {
    test('when success 200 was no key mapping should return error default',
        () async {
      final responseModel = mapping.defaultErrorResponse();

      expect(responseModel.statusCode, 200);
      expect(responseModel.isSuccess, true);
      expect(responseModel.object, null);
      expect(responseModel.message, 'No content found');
    });
  });
}
