import 'package:get_it/get_it.dart';

import 'dependency_injector.dart';

/// Concrete implementation using GetIt
class DependencyInjector implements IDependencyInjector {
  final GetIt _getIt;

  DependencyInjector(this._getIt);

  /// Factory constructor for the singleton instance
  factory DependencyInjector.instance() => DependencyInjector(GetIt.instance);

  @override
  void pushNewScope({required String scopeName, required void Function(DependencyInjector) init}) {
    _getIt.pushNewScope(scopeName: scopeName, init: (_) => init(this));
  }

  @override
  Future<void> popScope() async {
    await _getIt.popScope();
  }

  @override
  void registerSingleton<T extends Object>(T instance) {
    _getIt.registerSingleton<T>(instance);
  }

  @override
  void registerLazySingleton<T extends Object>(T Function() factory) {
    _getIt.registerLazySingleton<T>(factory);
  }

  @override
  void registerFactory<T extends Object>(T Function() factory) {
    _getIt.registerFactory<T>(factory);
  }

  @override
  T get<T extends Object>() {
    return _getIt.get<T>();
  }

  @override
  bool isRegistered<T extends Object>() {
    return _getIt.isRegistered<T>();
  }
}
