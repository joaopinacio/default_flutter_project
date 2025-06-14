import 'package:default_flutter_project/src/core/router/app_routes.dart';
import 'package:default_flutter_project/src/core/router/config/app_router.dart';
import 'package:default_flutter_project/src/features/login/login_route_constants.dart';

/// Navigation controller for the Login feature
class LoginNavigation {
  const LoginNavigation._();

  /// Singleton instance
  static const LoginNavigation instance = LoginNavigation._();

  /// Get the singleton router instance
  static IAppRouter get _router => AppRoutes.router;

  /// Navigate to login
  static void goToLogin() => _router.goNamed(LoginRouteConstants.loginName);

  /// Navigate to login with replacement (clear stack)
  static void goToLoginReplacement() => _router.pushReplacementNamed(LoginRouteConstants.loginName);

  /// Check if currently on login page
  static bool get isOnLoginPage => _router.currentLocation == LoginRouteConstants.loginPath;

  /// Get current route location
  static String get currentLocation => _router.currentLocation;
}
