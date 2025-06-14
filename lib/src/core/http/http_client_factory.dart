import 'package:dio/dio.dart';

import 'http_client.dart';
import 'config/http_config.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

class HttpClientFactory {
  static IHttpClient createClient({required HttpConfig config, bool enableLogging = false}) {
    final interceptors = <Interceptor>[];

    if (enableLogging) {
      interceptors.add(LoggingInterceptor());
    }
    interceptors.add(AuthInterceptor());

    return HttpClient(config: config, interceptors: interceptors);
  }
}
