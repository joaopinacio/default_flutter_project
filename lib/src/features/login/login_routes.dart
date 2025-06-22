import 'package:default_flutter_project/src/core/router/config/app_route.dart';
import 'package:default_flutter_project/src/features/login/login_injections.dart';
import 'package:default_flutter_project/src/features/login/login_route_constants.dart';
import 'package:default_flutter_project/src/features/login/presentation/login_page.dart';

class LoginRoutes extends AppRoute {
  LoginRoutes()
    : super.withInjector(
        path: LoginRouteConstants.loginPath,
        name: LoginRouteConstants.loginName,
        injector: LoginInjections(),
        builder: (context, pathParameters, queryParameters, extra) {
          return const LoginPage();
        },
      );
}
