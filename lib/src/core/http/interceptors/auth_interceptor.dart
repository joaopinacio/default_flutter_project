import 'package:default_flutter_project/src/core/constants/enviroment_urls_path.dart';
import 'package:default_flutter_project/src/core/http/config/http_config.dart';
import 'package:default_flutter_project/src/core/http/http_client_factory.dart';
import 'package:default_flutter_project/src/core/injection/app_injector.dart';
import 'package:default_flutter_project/src/core/services/auth/auth_service.dart';
import 'package:dio/dio.dart';
import 'dart:async';

/// AuthInterceptor manages automatic token refresh and concurrent requests
///
/// Features:
/// - Automatically adds Bearer token to requests
/// - Detects 401 (Unauthorized) responses and triggers token refresh
/// - Queues concurrent requests during refresh to avoid multiple attempts
/// - Retries requests that failed after successful token refresh
class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  // Static variables to manage concurrent token refresh
  static bool _isRefreshing = false;
  static Completer<bool>? _refreshCompleter;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = get<IAuthService>().accessToken;
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if error is 401 Unauthorized
    if (err.response?.statusCode == 401) {
      try {
        // If token refresh is already in progress, wait for completion
        if (_isRefreshing) {
          await _waitForTokenRefresh();
        } else {
          // Start token refresh process
          await _refreshToken();
        }

        // Retry original request with new token
        final newAccessToken = get<IAuthService>().accessToken;
        if (newAccessToken != null) {
          // Create HTTP client without auth interceptor to avoid loops
          final httpClient = HttpClientFactory.createClient(
            config: HttpConfig(baseUrl: EnviromentUrlsPath.baseUrl),
            enableLogging: false,
          );

          // Update authorization header with new token
          err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

          // Retry request using our HTTP client abstraction
          final response = await httpClient.fetch(err.requestOptions);
          handler.resolve(response);
          return;
        }
      } catch (e) {
        // If refresh failed, logout user
        await _handleRefreshFailure();
      }
    }

    // If not 401 error or refresh failed, pass error through
    handler.next(err);
  }

  Future<void> _refreshToken() async {
    if (_isRefreshing) return;

    _isRefreshing = true;
    _refreshCompleter = Completer<bool>();

    try {
      // final refreshRepository = getIt<LoginRefreshTokenRepository>();
      // final success = await refreshRepository.refreshToken();

      // if (success) {
      //   _refreshCompleter!.complete(true);
      // } else {
      //   _refreshCompleter!.completeError('Failed to refresh token');
      // }
      // TODO: Implement token refresh
      _refreshCompleter!.complete(true);
    } catch (e) {
      _refreshCompleter!.completeError(e);
      rethrow;
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }

  Future<void> _waitForTokenRefresh() async {
    if (_refreshCompleter != null) {
      try {
        await _refreshCompleter!.future;
      } catch (e) {
        // If refresh failed, it will be handled by calling method
        rethrow;
      }
    }
  }

  Future<void> _handleRefreshFailure() async {
    // Clear stored tokens
    final authService = get<IAuthService>();
    await authService.clearSession();
  }
}
