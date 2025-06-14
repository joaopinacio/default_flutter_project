// ignore_for_file: unused_field

import 'package:dio/dio.dart';

import 'config/http_config.dart';
import 'config/http_exceptions.dart';

abstract class IHttpClient {
  Future<Response> fetch(RequestOptions options);
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters});
  Future<Response> post(String path, {dynamic data});
  Future<Response> put(String path, {dynamic data});
  Future<Response> delete(String path);
  Future<Response> patch(String path, {dynamic data});
}

class HttpClient implements IHttpClient {
  final Dio _dio;
  final HttpConfig _config;

  HttpClient({required HttpConfig config, List<Interceptor>? interceptors})
    : _config = config,
      _dio = Dio(
        BaseOptions(
          baseUrl: config.baseUrl,
          connectTimeout: config.connectTimeout,
          receiveTimeout: config.receiveTimeout,
          headers: config.defaultHeaders,
        ),
      ) {
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  @override
  Future<Response> fetch(RequestOptions options) async {
    try {
      return await _dio.fetch(options);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> patch(String path, {dynamic data}) async {
    try {
      return await _dio.patch(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException('Request timed out');
      case DioExceptionType.badResponse:
        return HttpException(
          statusCode: error.response?.statusCode ?? 500,
          message: error.response?.statusMessage ?? 'Unknown error',
        );
      case DioExceptionType.cancel:
        return CancelledException('Request was cancelled');
      default:
        return NetworkException('Network error occurred');
    }
  }
}
