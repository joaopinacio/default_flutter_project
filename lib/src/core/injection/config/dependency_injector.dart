/// Abstract interface for dependency injection operations
abstract class IDependencyInjector {
  /// Push a new scope with the given name and initialization function
  void pushNewScope({required String scopeName, required void Function(IDependencyInjector) init});

  /// Pop the current scope
  Future<void> popScope();

  /// Register a singleton instance
  void registerSingleton<T extends Object>(T instance);

  /// Register a lazy singleton factory
  void registerLazySingleton<T extends Object>(T Function() factory);

  /// Register a factory that creates a new instance each time
  void registerFactory<T extends Object>(T Function() factory);

  /// Get an instance of the registered type
  T get<T extends Object>();

  /// Check if a type is registered
  bool isRegistered<T extends Object>();
}
