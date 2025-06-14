import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';

/// Concrete implementation of AppRouter using GoRouter
class AppRouter implements IAppRouter {
  final GoRouter _goRouter;

  AppRouter(this._goRouter);

  /// Factory constructor that creates a GoRouter with default configuration
  factory AppRouter.create({
    required List<RouteBase> routes,
    String? initialLocation,
    GlobalKey<NavigatorState>? navigatorKey,
    GoRouterRedirect? redirect,
    int redirectLimit = 5,
    bool routerNeglect = false,
    String? restorationScopeId,
    GoExceptionHandler? onException,
    bool debugLogDiagnostics = false,
    List<NavigatorObserver>? observers,
  }) {
    final goRouter = GoRouter(
      routes: routes,
      initialLocation: initialLocation,
      navigatorKey: navigatorKey,
      redirect: redirect,
      redirectLimit: redirectLimit,
      routerNeglect: routerNeglect,
      restorationScopeId: restorationScopeId,
      onException: onException,
      debugLogDiagnostics: debugLogDiagnostics,
      observers: observers,
    );

    return AppRouter(goRouter);
  }

  @override
  void go(String path, {Object? extra}) => _goRouter.go(path, extra: extra);

  @override
  void goNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    _goRouter.goNamed(name, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }

  @override
  void push(String path, {Object? extra}) => _goRouter.push(path, extra: extra);

  @override
  void pushNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    _goRouter.pushNamed(name, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
  }

  @override
  void pushReplacement(String path, {Object? extra}) => _goRouter.pushReplacement(path, extra: extra);

  @override
  void pushReplacementNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    _goRouter.pushReplacementNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  @override
  void pop([Object? result]) => _goRouter.pop(result);

  @override
  void popUntil(String path) {
    // GoRouter doesn't have popUntil by path, so we implement it
    while (_goRouter.canPop() && _goRouter.routerDelegate.currentConfiguration.uri.path != path) {
      _goRouter.pop();
    }
  }

  @override
  bool canPop() => _goRouter.canPop();

  @override
  String get currentLocation => _goRouter.routerDelegate.currentConfiguration.uri.path;

  @override
  RouterDelegate<Object> get routerDelegate => _goRouter.routerDelegate;

  @override
  RouteInformationParser<Object> get routeInformationParser => _goRouter.routeInformationParser;

  @override
  RouteInformationProvider? get routeInformationProvider => _goRouter.routeInformationProvider;

  @override
  RouterConfig<Object> get routerConfig => _goRouter;
}
