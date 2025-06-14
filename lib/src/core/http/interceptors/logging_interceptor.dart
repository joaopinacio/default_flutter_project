import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  final bool enabled;

  LoggingInterceptor({this.enabled = true});

  // ANSI color codes
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _blue = '\x1B[34m';
  static const String _cyan = '\x1B[36m';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (enabled) {
      log('$_blue🌐 REQUEST[${options.method}] => PATH: ${options.path}$_reset');
      log('$_cyan📋 REQUEST[${options.method}] => HEADERS: ${options.headers}$_reset');
      if (options.data != null) {
        log('$_cyan📦 REQUEST[${options.method}] => BODY: ${options.data}$_reset');
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (enabled) {
      log('$_green✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}$_reset');
      log('$_green📥 RESPONSE[${response.statusCode}] => DATA: ${response.data}$_reset');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (enabled) {
      log('$_red❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}$_reset');
      log('$_red⚠️ ERROR[${err.response?.statusCode}] => MESSAGE: ${err.message}$_reset');
      if (err.response?.data != null) {
        log('$_red📦 ERROR[${err.response?.statusCode}] => DATA: ${err.response?.data}$_reset');
      }
    }
    handler.next(err);
  }
}
