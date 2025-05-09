import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_template/main.dart';
import 'package:flutter_mvvm_template/models/api_response.dart';
import 'package:flutter_mvvm_template/network_service/api_response_mapping.dart';
import 'package:flutter_mvvm_template/network_service/app_service_management.dart';
import 'package:flutter_mvvm_template/network_service/auth_interceptor.dart';

class BaseAPIService {
  String baseUrl;
  String endpoint;
  Dio dio = Dio();
  Connectivity connectivity = Connectivity();
  ApiResponseMapping apiResponseMapping = ApiResponseMapping();

  BaseAPIService({
    required this.baseUrl, 
    required this.endpoint,
    Dio? dio,
    Connectivity? connectivity,
  }) {
    this.dio = dio ?? Dio();
    this.connectivity = connectivity ?? Connectivity();
    if (kDebugMode) {
      this.dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: appConfig.flavor.contains('dev')));
    }
    this.dio.interceptors.add(AuthInterceptor());
    this.dio.options.connectTimeout = const Duration(seconds: 30);
    this.dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  Future<bool> isConnectInternet() async {
    var connectivityResult = await (connectivity.checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }

  // Get
  Future<APIResponse> callGetAPI({
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? myHeaders
  }) async {
    if (!await isConnectInternet()) {
      return apiResponseMapping.internetError();
    }
    try {
      Response<dynamic> response = await dio.get(
        baseUrl + endpoint,
        options: Options(
          headers: myHeaders, 
          responseType: ResponseType.plain
        ), 
        queryParameters: parameters,
      );
      return apiResponseMapping.returnSuccessResponse(response);
    } on DioException catch (e) {
      return apiResponseMapping.returnErrorResponse(e);
    }
  }

  // Post
  Future<APIResponse> callPostAPI({
    dynamic body,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? myHeaders
  }) async {
    if (!await isConnectInternet()) {
      return apiResponseMapping.internetError();
    }
    
    try {
      await checkCertificate(dio);
      Response<dynamic> response = await dio.post(
        baseUrl + endpoint,
        options: Options(
          headers: myHeaders, 
          responseType: ResponseType.plain
        ),
        data: body,
        queryParameters: parameters,
      );
      return apiResponseMapping.returnSuccessResponse(response);
    } on DioException catch (e) {
      return apiResponseMapping.returnErrorResponse(e);
    }
  }

  // Delete
  Future<APIResponse> callDeleteAPI({
    dynamic body,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? myHeaders
  }) async {
    if (!await isConnectInternet()) {
      return apiResponseMapping.internetError();
    }
    
    try {
      await checkCertificate(dio);
      Response<dynamic> response = await dio.delete(
        baseUrl + endpoint,
        options: Options(headers: myHeaders, responseType: ResponseType.plain),
        data: body,
        queryParameters: parameters,
      );
      return apiResponseMapping.returnSuccessResponse(response);
    } on DioException catch (e) {
      return apiResponseMapping.returnErrorResponse(e);
    }
  }

  // Put
  Future<APIResponse> callPutAPI({
    dynamic body,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? myHeaders
  }) async {
    if (!await isConnectInternet()) {
      return apiResponseMapping.internetError();
    }
    
    try {
      await checkCertificate(dio);
      Response<dynamic> response = await dio.put(
        baseUrl + endpoint,
        options: Options(
          headers: myHeaders, 
          responseType: ResponseType.plain
        ),
        data: body,
        queryParameters: parameters
      );
      return apiResponseMapping.returnSuccessResponse(response);
    } on DioException catch (e) {
      return apiResponseMapping.returnErrorResponse(e);
    }
  }
}