import 'dart:developer';

import 'package:flutter/material.dart';

/// A widget that manages the lifecycle of a dependency injection scope.
///
/// Automatically initializes the scope when the widget is created and
/// disposes of it when the widget is destroyed.
class ScopeLifecycleWidget extends StatefulWidget {
  const ScopeLifecycleWidget({
    required this.child,
    required this.onInit,
    required this.onDispose,
    this.scopeName,
    super.key,
  });

  /// The widget to wrap with scope lifecycle management
  final Widget child;

  /// Called when the widget is initialized (equivalent to setUp)
  final Future<void> Function() onInit;

  /// Called when the widget is disposed (equivalent to tearDown)
  final Future<void> Function() onDispose;

  /// Optional name for debugging purposes
  final String? scopeName;

  @override
  State<ScopeLifecycleWidget> createState() => _ScopeLifecycleWidgetState();
}

class _ScopeLifecycleWidgetState extends State<ScopeLifecycleWidget> {
  bool _isInitialized = false;
  bool _isDisposing = false;

  @override
  void initState() {
    super.initState();
    _initializeScope();
  }

  @override
  void dispose() {
    _disposeScope();
    super.dispose();
  }

  Future<void> _initializeScope() async {
    if (_isInitialized) return;

    try {
      await widget.onInit();
      _isInitialized = true;
    } catch (error, stackTrace) {
      _logError('Failed to initialize scope', error, stackTrace);
    }
  }

  Future<void> _disposeScope() async {
    if (_isDisposing || !_isInitialized) return;

    _isDisposing = true;

    try {
      await widget.onDispose();
    } catch (error, stackTrace) {
      _logError('Failed to dispose scope', error, stackTrace);
    }
  }

  void _logError(String message, Object error, StackTrace stackTrace) {
    final scopeInfo = widget.scopeName != null ? ' (${widget.scopeName})' : '';
    log('$message$scopeInfo: $error', error: error, stackTrace: stackTrace);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
