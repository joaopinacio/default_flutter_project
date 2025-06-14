import 'package:default_flutter_project/src/core/router/config/app_router_logger.dart';
import 'package:default_flutter_project/src/core/router/config/base_app_route.dart';
import 'package:default_flutter_project/src/features/home/home_routes.dart';
import 'package:flutter/material.dart';

import 'config/app_router.dart';
import 'config/app_router_impl.dart';
import 'config/route_converter.dart';

class AppRoutes {
  const AppRoutes._();

  /// The main router instance using our abstraction
  static final IAppRouter router = AppRouter.create(
    observers: [AppRouteLogger()],
    routes: RouteConverter.toGoRoutes(_routes),
  );

  /// List of all app routes using our abstraction
  static final List<BaseAppRoute> _routes = [
    HomeRoutes(),
    // Add more routes here
  ];

  /// Router configuration for MaterialApp.router
  static RouterConfig<Object> get routerConfig => router.routerConfig;
}
