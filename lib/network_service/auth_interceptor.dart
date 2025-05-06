import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_mvvm_template/main.dart';
import 'package:flutter_mvvm_template/network_service/api_response_mapping.dart';
import 'package:flutter_mvvm_template/constants/app_network_urls.dart';
import 'package:flutter_mvvm_template/utils/pprint.dart';
class AuthInterceptor extends Interceptor {
  AuthInterceptor();
  var count = 0;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var myHeaders = options.headers;
    var headers = await getGeneralHeaders(myHeaders);
    options.headers = headers;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(err, ErrorInterceptorHandler handler) async {
   // Handle 'Unauthorized' universally
    if (err.response?.statusCode == 401) {
      if (await refreshToken()) {
        try {
          return handler.resolve(await retry(err.requestOptions));
        } on DioException catch (e) {
          // resume call api
          pprint("error retry call api ${e.message}");
          if (e.response?.statusCode == 401) {
            // TODO: Add logout and reset root
            return;
          }
          return handler.next(e);
        }
      } else {
        // TODO: Add logout and reset root
        
        return;
      }
    } 
    return handler.next(err);
  }

  Future<Map<String, dynamic>> getGeneralHeaders(Map<String, dynamic>? headers) async {
    var token = ''; //await SecuritySharedPrefs.shared.getToken;

    Map<String, dynamic> tempHeaders = {
      Headers.contentTypeHeader: Headers.jsonContentType,
      Headers.acceptHeader: Headers.jsonContentType,
      'Authorization': 'Bearer $token',
    };

    if (headers != null) {
      tempHeaders.addAll(headers);
    }
    return tempHeaders;
  }

  Future<bool> refreshToken() async {
    var headers = await getGeneralHeaders(null);
    var token = ''; //await SecuritySharedPrefs.shared.getRefreshToken;
    var dio = Dio();
    dio.interceptors.add(CurlLoggerDioInterceptor());
    pprint("============== Refresh Token ==============");
    try {
      var response = await dio.get(
        appConfig.baseApiUrl + AppNetworkUrls.refreshToken,
        options: Options(
          headers: headers,
          responseType: ResponseType.plain
        ),
        data: {
          'refreshToken': token,
        }
      );
      if (response.statusCode == 200) {
        var result = ApiResponseMapping().returnSuccessResponse(response);
        if (result.isSuccess) {
          final json = await result.object;
          String token = json['token'];
          pprint("token $token");
          // await SecuritySharedPrefs.shared.setToken(token);
          kPrint("============== Refresh Token Success ==============");
          return true;
        }
      }
    } on DioException catch (e) {
      pprint('refresh token error ${e.response}');
    }
    kPrint("============== End Refresh Token ==============");
    return false; 
  }

  Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    var dio = Dio();
    dio.interceptors.add(CurlLoggerDioInterceptor());
    Map<String, dynamic> headers = await getGeneralHeaders(null);

    final options = Options(
      method: requestOptions.method,
      headers: headers,
      responseType: ResponseType.plain
    );

    final cloneReq = await dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options
    );
    return cloneReq;
  }
}