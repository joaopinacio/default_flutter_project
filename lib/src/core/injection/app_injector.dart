import 'package:default_flutter_project/src/core/injection/app_injections.dart';

import 'config/dependency_injector.dart';
import 'config/dependency_injector_impl.dart';

/// Global injector instance for accessing dependencies throughout the app
late final IDependencyInjector injector;

/// Initialize the global injector
Future<void> initializeInjector() async {
  injector = DependencyInjector.instance();

  // Set up app-wide dependencies
  final appInjections = AppInjections();
  await appInjections.setUp();
}

/// Convenience method to get dependencies
T get<T extends Object>() => injector.get<T>();

/// Convenience method to check if a dependency is registered
bool isRegistered<T extends Object>() => injector.isRegistered<T>();
