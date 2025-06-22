import 'package:default_flutter_project/src/core/injection/config/base_injection.dart';
import 'package:default_flutter_project/src/core/injection/config/scope_lifecycle_widget.dart';
import 'package:flutter/widgets.dart';

import 'base_app_route.dart';

/// Concrete implementation of BaseAppRoute that takes builder in constructor
class AppRoute implements BaseAppRoute {
  const AppRoute({
    required this.path,
    required this.builder,
    this.name,
    this.redirect,
    this.routes = const [],
    this.parentPath,
  });

  /// Alternative constructor that automatically wraps the builder with ScopeLifecycleWidget
  AppRoute.withInjector({
    required this.path,
    required BaseInjection injector,
    required Widget Function(
      BuildContext context,
      Map<String, String> pathParameters,
      Map<String, String> queryParameters,
      Object? extra,
    )
    builder,
    this.name,
    this.redirect,
    this.routes = const [],
    this.parentPath,
  }) : builder = ((context, pathParameters, queryParameters, extra) {
         return ScopeLifecycleWidget(
           scopeName: injector.scopeName,
           onDispose: injector.tearDown,
           onInit: injector.setUp,
           child: builder(context, pathParameters, queryParameters, extra),
         );
       });

  @override
  final String path;

  @override
  final String? name;

  @override
  final RouteBuilder builder;

  @override
  final RouteRedirect? redirect;

  @override
  final List<BaseAppRoute> routes;

  @override
  final String? parentPath;
}
