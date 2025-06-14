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
  }

  Future<void> tearDown() async {
    log('\x1B[91mTearing down ${scopeName.toUpperCase()} injections');
    await injector.popScope();
  }
}
