import 'package:flutter/widgets.dart';

/// Type definition for route builder function
typedef RouteBuilder =
    Widget Function(
      BuildContext context,
      Map<String, String> pathParameters,
      Map<String, String> queryParameters,
      Object? extra,
    );

/// Type definition for route redirect function
typedef RouteRedirect =
    String? Function(
      BuildContext context,
      Map<String, String> pathParameters,
      Map<String, String> queryParameters,
      Object? extra,
    );

/// Abstract base interface for defining application routes
abstract class BaseAppRoute {
  /// The path pattern for this route
  String get path;

  /// Optional name for named navigation
  String? get name;

  /// Builder function to create the widget for this route
  RouteBuilder get builder;

  /// Optional redirect method
  RouteRedirect? get redirect;

  /// Child routes (for nested routing)
  List<BaseAppRoute> get routes;

  /// Parent path for nested routes
  String? get parentPath;
}
