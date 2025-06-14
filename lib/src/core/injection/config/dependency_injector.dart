/// Abstract interface for dependency injection operations
abstract class IDependencyInjector {
  /// Push a new scope with the given name and initialization function
  void pushNewScope({required String scopeName, required void Function(IDependencyInjector) init});

  /// Pop the current scope
  Future<void> popScope();

  /// Register a singleton instance
  void registerSingleton<T extends Object>(T instance);

  /// Register a singleton async instance
  void registerSingletonAsync<T extends Object>(Future<T> Function() factory);

  /// Register a lazy singleton factory
  void registerLazySingleton<T extends Object>(T Function() factory);

  /// Register a lazy singleton async instance
  void registerLazySingletonAsync<T extends Object>(Future<T> Function() factory);

  /// Register a factory that creates a new instance each time
  void registerFactory<T extends Object>(T Function() factory);

  /// Register a factory async instance
  void registerFactoryAsync<T extends Object>(Future<T> Function() factory);

  /// Get an instance of the registered type
  T get<T extends Object>();

  /// Get an async instance of the registered type (waits for it to be ready)
  Future<T> getAsync<T extends Object>();

  /// Check if a type is registered
  bool isRegistered<T extends Object>();

  /// Wait for all async dependencies to be ready
  Future<void> allReady({Duration? timeout, bool ignorePendingAsyncCreation = false});
}
