import 'dart:developer';

//import 'package:chucker_flutter/chucker_flutter.dart';
/*import 'package:chucker_flutter/chucker_flutter.dart';*/
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/data/network/ApiEndPoints.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:curate/src/utils/date_time_utils.dart';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';

import 'manager/preferences_manager.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    // const _baseUrlDev = 'http://54.176.169.179:3020/';
    // const _baseUrllive = 'http://54.176.169.179:3020/';
    // const _baseUrlDev = "https://api.curate.health";

    var baseUrl = AppConstants.baseUrlDev;
    final BaseOptions options = BaseOptions(
        sendTimeout: Duration(seconds: 30000),
        connectTimeout: Duration(seconds: 30000),
        receiveTimeout: Duration(seconds: 30000),
        baseUrl: baseUrl,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    _dio = Dio(options);
    _dio.interceptors.add(AuthorizationInterceptor());
    _dio.interceptors.add(LoggingInterceptor());
    _dio.interceptors.add(ChuckerDioInterceptor());
    // _dio.interceptors.add(ChuckerDioInterceptor());
  }

  Dio getDio() => _dio;
}

class AuthorizationInterceptor extends InterceptorsWrapper {
  final _preferences = GetIt.I<PreferencesManager>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Send user token in headers if it is available
    print("options.path");
    print(options.uri);
    print(options.baseUrl);
    if (options.path != ApiEndPoints().app_version) {
      final token = await _preferences.getUserToken();
      options.headers['language'] = 'en';
      var dateTime = DateTime.now();
      Duration offset = dateTime.timeZoneOffset;
      var minute = offset.inMinutes;
      String offsetString = offset.isNegative ? "+" : "-$minute";
      options.headers['utcoffset'] = offsetString;
      options.headers['timezone'] = DateTime.now().timeZoneName;
      if (token != null && token.isNotEmpty) {
        print("token");
        print(token);
        log(token);
        options.headers['authorization'] = 'Bearer $token';
      }

      /*  if(options.path == ApiEndPoints().delete){
       options.baseUrl = "http://54.176.169.179:3020";
       print("options.path");
       print(options.uri);
       print(options.baseUrl);
     }*/
    }

    super.onRequest(options, handler);
  }
}

class LoggingInterceptor extends InterceptorsWrapper {
  // todo disable for release builds
  final _logger = GetIt.I<Logger>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d(options.path);
    _logger.d(options.queryParameters.toString());
    _logger.d(options.headers.toString());
    _logger.d(options.data);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d(response.data);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final errorMessage = err.message;
    final errorData = err.response?.data;
    _logger.e(errorMessage);
    if (errorData != null) {
      _logger.e(errorData);
    }
    super.onError(err, handler);
  }
}
