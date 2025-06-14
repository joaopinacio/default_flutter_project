import 'package:default_flutter_project/src/core/router/app_routes.dart';
import 'package:default_flutter_project/src/features/home/home_route_constants.dart';

/// Navigation controller for the Home feature
class HomeNavigation {
  const HomeNavigation._();

  /// Singleton instance
  static const HomeNavigation instance = HomeNavigation._();

  /// Get the singleton router instance
  static get _router => AppRoutes.router;

  /// Navigate to home with replacement (clear stack)
  static void goToHome() => _router.pushReplacementNamed(HomeRouteConstants.homeName);

  /// Pop to home (remove all routes above home)
  static void popToHome() => _router.popUntil(HomeRouteConstants.homePath);

  /// Check if currently on home page
  static bool get isOnHomePage => _router.currentLocation == HomeRouteConstants.homePath;

  /// Get current route location
  static String get currentLocation => _router.currentLocation;
}
