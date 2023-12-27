import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../injection_container/injection_container.dart';
import '../error/exceptions.dart';
import '../local/auth_local_datasource.dart';
import 'end_points.dart';

class ApiBaseHelper {
  final String _baseUrl = baseUrl;
  final Dio dio = Dio();

  void dioInit() {
    dio.options.baseUrl = _baseUrl;
    dio.options.headers = headers;
    dio.options.sendTimeout =const Duration(milliseconds:15000 ) ; // time in ms
    dio.options.connectTimeout = const Duration(milliseconds:15000 ); // time in ms
  }

  void updateLocalInHeaders(String local) {
    headers["Accept-Language"] = local;
    dio.options.headers = headers;
  }

  ApiBaseHelper();
  Map<String, String> headers = {
    "accept": "application/json",
    "Content-Type": 'multipart/form-data'
  };

  Future<dynamic> get({
    required String url,
  }) async {
    final token = sharedPreferences.get(cacheTokenConst);
    try {
      // final cookieJar = CookieJar();
      // dio.interceptors.add(CookieManager(cookieJar));

      // headers["Content-language"] = local;
      if (token != null) {
        headers["Authorization"] = "Bearer $token";
        // dio.options.headers = headers;
      }
      log("url is =>>>$url");
      log("url is =>>>$token");
      // final lang = headers["Accept-Language"] == "en" ? "en_US" : "ar_001";
      final Response response = await dio.get(url);
      log("response =>>>$response");
      final responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioException catch (e) {
      log(e.toString());
      throw ServerException(message: e.message??"serverError");
    }
  }

  Future<dynamic> put({
    required String url,
    String? token,
    Map<String, dynamic>? body,
  }) async {
    try {
      // headers["Content-language"] = local;
      final Response response;
      if (token != null) {
        headers["Authorization"] = "Bearer $token";
        dio.options.headers = headers;
      }
      if (body != null) {
        FormData formData = FormData.fromMap(body);
        response = await dio.put(url, data: formData);
      } else {
        response = await dio.put(url);
      }
      final responseJson = _returnResponse(response);
      log(responseJson);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioException catch (e) {
      throw ServerException(message: e.message??"Server Error");
    }
  }

  Future<dynamic> post(
      {required String url,
      required Map<String, dynamic> body,
      String? token}) async {
    try {
      // headers["Content-language"] = local;
      // final cookieJar = CookieJar();
      // dio.interceptors.add(CookieManager(cookieJar));
      final token = sharedPreferences.get(cacheTokenConst);
      log(token.toString());
      if (token != null) {
        headers["Authorization"] = "Bearer $token";
        headers["Accept"] = "application/json";
        dio.options.headers = headers;
      }
      FormData formData = FormData.fromMap(body);
      final Response response = await dio.post(url, data: formData);
      log(url);
      final responseJson = _returnResponse(response);
      return responseJson;
    } on DioException catch (e) {
      throw ServerException(
          message: e.response != null
              ? e.response!.data['message'] ?? "Something went wrong"
              : "Something went wrong");
    } on SocketException {
      throw ServerException(message: "No internet,please try again later");
    }
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw ServerException(message: response.data['message']);
      case 422:
        throw response.data.toString();
      case 401:
      case 403:
        throw UnauthorizedException(message: response.data);
      case 404:
        throw UnauthorizedException(message: "Error occurred ");
      case 500:
        throw ServerException(
            message:
                'Error occurred while Communication with Server with StatusCode : ${response.statusCode} ${response.data}');
      default:
        debugPrint(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode} ${response.data}');
        throw ServerException(
            message:
                'Error occurred while Communication with Server with StatusCode : ${response.statusCode} ${response.data}');
    }
  }
}

class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);
  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([message]) : super(message, "Unauthorized: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
