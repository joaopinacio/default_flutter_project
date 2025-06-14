import 'dart:developer';

import 'dependency_injector.dart';
import 'dependency_injector_impl.dart';

abstract class BaseInjection {
  BaseInjection({required this.scopeName, required this.registrations, IDependencyInjector? injector})
    : injector = injector ?? DependencyInjector.instance();

  final String scopeName;
  final List<void Function(IDependencyInjector)> registrations;
  final IDependencyInjector injector;

  Future<void> setUp() async {
    log('\x1B[92mSetting up ${scopeName.toUpperCase()} injections');

    injector.pushNewScope(
      scopeName: scopeName,
      init: (di) {
        for (final register in registrations) {
          register(di);
        }
      },
    );

    // Wait for all async registrations to be ready
    await _waitForAsyncDependencies();
  }

  /// Wait for all async dependencies to be ready
  Future<void> _waitForAsyncDependencies() async {
    try {
      // Use GetIt's allReady to wait for all async singletons to be ready
      await injector.allReady();
    } catch (e) {
      log('⚠️ Error waiting for async dependencies: $e');
      rethrow;
    }
  }

  Future<void> tearDown() async {
    log('\x1B[91mTearing down ${scopeName.toUpperCase()} injections');
    await injector.popScope();
  }
}
