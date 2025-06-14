import 'package:go_router/go_router.dart';

import 'base_app_route.dart';

/// Converts BaseAppRoute instances to GoRoute instances
class RouteConverter {
  const RouteConverter._();

  /// Convert a single BaseAppRoute to GoRoute
  static GoRoute toGoRoute(BaseAppRoute appRoute) {
    return GoRoute(
      path: appRoute.path,
      name: appRoute.name,
      builder: (context, state) {
        return appRoute.builder(context, state.pathParameters, state.uri.queryParameters, state.extra);
      },
      redirect: appRoute.redirect != null
          ? (context, state) {
              return appRoute.redirect!(context, state.pathParameters, state.uri.queryParameters, state.extra);
            }
          : null,
      routes: appRoute.routes.map(toGoRoute).toList(),
    );
  }

  /// Convert a list of BaseAppRoutes to GoRoutes
  static List<RouteBase> toGoRoutes(List<BaseAppRoute> appRoutes) {
    return appRoutes.map(toGoRoute).toList();
  }
}
