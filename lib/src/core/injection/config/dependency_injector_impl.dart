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
  void registerSingletonAsync<T extends Object>(Future<T> Function() factory) {
    _getIt.registerSingletonAsync<T>(factory);
  }

  @override
  void registerLazySingleton<T extends Object>(T Function() factory) {
    _getIt.registerLazySingleton<T>(factory);
  }

  @override
  void registerLazySingletonAsync<T extends Object>(Future<T> Function() factory) {
    _getIt.registerLazySingletonAsync<T>(factory);
  }

  @override
  void registerFactory<T extends Object>(T Function() factory) {
    _getIt.registerFactory<T>(factory);
  }

  @override
  void registerFactoryAsync<T extends Object>(Future<T> Function() factory) {
    _getIt.registerFactoryAsync<T>(factory);
  }

  @override
  T get<T extends Object>() {
    return _getIt.get<T>();
  }

  @override
  Future<T> getAsync<T extends Object>() {
    return _getIt.getAsync<T>();
  }

  @override
  bool isRegistered<T extends Object>() {
    return _getIt.isRegistered<T>();
  }

  @override
  Future<void> allReady({Duration? timeout, bool ignorePendingAsyncCreation = false}) {
    return _getIt.allReady(timeout: timeout, ignorePendingAsyncCreation: ignorePendingAsyncCreation);
  }
}
