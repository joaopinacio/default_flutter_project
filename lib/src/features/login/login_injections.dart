import 'package:default_flutter_project/src/core/injection/config/base_injection.dart';
import 'package:default_flutter_project/src/features/login/presentation/login_view_model.dart';

class LoginInjections extends BaseInjection {
  LoginInjections()
    : super(
        scopeName: 'Login',
        registrations: [(i) => i.registerLazySingleton<LoginViewModel>(() => LoginViewModel())],
      );
}
