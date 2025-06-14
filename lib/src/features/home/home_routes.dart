import 'package:default_flutter_project/src/core/injection/config/scope_lifecycle_widget.dart';
import 'package:default_flutter_project/src/core/router/config/app_route.dart';
import 'package:default_flutter_project/src/features/home/home_injections.dart';
import 'package:default_flutter_project/src/features/home/home_route_constants.dart';
import 'package:default_flutter_project/src/features/home/presentation/home_page.dart';

class HomeRoutes extends AppRoute {
  HomeRoutes()
    : super(
        path: HomeRouteConstants.homePath,
        name: HomeRouteConstants.homeName,
        builder: (context, pathParameters, queryParameters, extra) {
          final homeInjector = HomeInjections();

          return ScopeLifecycleWidget(
            scopeName: homeInjector.scopeName,
            onDispose: homeInjector.tearDown,
            onInit: homeInjector.setUp,
            child: const HomePage(),
          );
        },
      );
}
