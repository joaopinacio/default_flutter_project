import 'package:default_flutter_project/src/core/injection/config/base_injection.dart';
import 'package:default_flutter_project/src/features/home/presentation/home_view_model.dart';

class HomeInjections extends BaseInjection {
  HomeInjections()
    : super(scopeName: 'Home', registrations: [(i) => i.registerLazySingleton<HomeViewModel>(() => HomeViewModel())]);
}
