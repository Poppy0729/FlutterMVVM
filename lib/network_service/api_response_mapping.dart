import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_mvvm_template/models/api_response.dart';

class ApiResponseMapping {
  // Check Response Status and Return Data in Success
  APIResponse returnSuccessResponse(Response response) {
    var res = convertStringToJson(response.data);
    return APIResponse(
      statusCode: response.statusCode, 
      object: res, 
      message: response.statusMessage,
      isSuccess: true
    );
  }
  
  // Check Response Status and Return Data in Error
  APIResponse returnErrorResponse(DioException error) {
    var message = error.message;
    String? code;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection Timeout :(';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send Timeout :(';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive Timeout :(';
        break;
      default:
        message = error.message;
    }

    var res = convertStringToJson(error.response?.data);
    if (error.response?.statusCode != 403) {
      code = mapCodeError(res);
    } 

    return APIResponse(
      statusCode: error.response?.statusCode ?? 400,
      message: message,
      isSuccess: false,
      object: res,
      code: code
    );
  }

  String? mapCodeError(dynamic data) {
    if (data is String) {
      return null;
    } else if (data != null && data?.containsKey("code")) {
      final code = data['code'];
      return code;
    }
    return null;
  }

  APIResponse internetError() {
    return APIResponse(
        statusCode: 9999,
        message: 'No Internet Connection Available :(',
        isSuccess: false);
  }

  APIResponse defaultErrorResponse() {
    return APIResponse(
        statusCode: 200, message: 'No content found', isSuccess: true);
  }

  dynamic convertStringToJson(String? data) {
    if (data == null || data.isEmpty) return data;
    try {
      var json = jsonDecode(data);
      return json;
    } catch (e) {
      return data;
    }
  }
}
