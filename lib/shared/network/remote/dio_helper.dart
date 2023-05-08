import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://alizidan.me/api/',
      receiveDataWhenStatusError: true,
      validateStatus: (statusCode) {
        if (statusCode == null) {
          return false;
        }
        if (statusCode == 401) {
          // your http status code
          return true;
        }
        if (statusCode == 422) {
          // your http status code
          return true;
        } else {
          return statusCode >= 200 && statusCode < 300;
        }
      },
    ));
  }

  static Future<Response> getData({
    required String url,
    query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    return await dio!.get(url, queryParameters: query ?? null);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    return dio!.post(url, queryParameters: query ?? null, data: data);
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
    String lang = 'en',
    String? token,
  }) async {
    Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        });

    dio!.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    return dio!.put(url, queryParameters: query ?? null, data: data);
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    return dio!.delete(url, queryParameters: query ?? null);
  }
}
