import 'package:default_flutter_project/src/app.dart';
import 'package:flutter/material.dart';

import 'src/core/injection/app_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the global injector
  await initializeInjector();

  runApp(const AppWidget());
}
