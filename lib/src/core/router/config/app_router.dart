import 'package:flutter/material.dart';

/// Abstract interface for routing operations
abstract class IAppRouter {
  /// Navigate to a route by path
  void go(String path, {Object? extra});

  /// Navigate to a route by name
  void goNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  });

  /// Push a new route on top of the current route
  void push(String path, {Object? extra});

  /// Push a new route by name on top of the current route
  void pushNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  });

  /// Replace the current route with a new one
  void pushReplacement(String path, {Object? extra});

  /// Replace the current route with a new one by name
  void pushReplacementNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  });

  /// Pop the current route
  void pop([Object? result]);

  /// Pop until a specific route
  void popUntil(String path);

  /// Check if it's possible to pop
  bool canPop();

  /// Get the current location
  String get currentLocation;

  /// Get the router delegate for MaterialApp
  RouterDelegate<Object> get routerDelegate;

  /// Get the route information parser for MaterialApp
  RouteInformationParser<Object> get routeInformationParser;

  /// Get the route information provider for MaterialApp
  RouteInformationProvider? get routeInformationProvider;

  /// Get the router configuration for MaterialApp.router
  RouterConfig<Object> get routerConfig;
}
