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
