import 'dart:developer';

import 'package:flutter/material.dart';

/// Custom route observer for logging navigation events
class AppRouteLogger extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    // Add your logging logic here
    log('📍 \x1B[94mNavigated to: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);

    // Add your logging logic here
    log('⬅️ \x1B[93mPopped from: ${route.settings.name}');
  }
}
