import 'package:default_flutter_project/src/core/injection/config/scope_lifecycle_widget.dart';
import 'package:default_flutter_project/src/core/router/config/app_route.dart';
import 'package:default_flutter_project/src/features/login/login_injections.dart';
import 'package:default_flutter_project/src/features/login/login_route_constants.dart';
import 'package:default_flutter_project/src/features/login/presentation/login_page.dart';

class LoginRoutes extends AppRoute {
  LoginRoutes()
    : super(
        path: LoginRouteConstants.loginPath,
        name: LoginRouteConstants.loginName,
        builder: (context, pathParameters, queryParameters, extra) {
          final loginInjector = LoginInjections();

          return ScopeLifecycleWidget(
            scopeName: loginInjector.scopeName,
            onDispose: loginInjector.tearDown,
            onInit: loginInjector.setUp,
            child: const LoginPage(),
          );
        },
      );
}
