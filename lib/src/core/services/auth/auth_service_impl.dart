import 'dart:convert';
import 'dart:developer';

import 'package:default_flutter_project/src/core/storage/app_storage.dart';

import 'auth_service.dart';
import 'models/auth_token.dart';
import 'models/user_model.dart';

/// Concrete implementation of AuthService using SharedPreferences
class AuthService implements IAuthService {
  AuthService(this._storage);

  final AppStorage _storage;

  // Storage key for the complete auth token (includes user data)
  static const String _authTokenKey = 'auth_token_data';

  // Public auth token - single source of truth for user session
  AuthToken? authToken;

  bool _isInitialized = false;

  @override
  String? get accessToken => authToken?.accessToken;

  @override
  String? get refreshToken => authToken?.refreshToken;

  @override
  UserModel? get currentUser => authToken?.user;

  @override
  bool get isAuthenticated => authToken != null;

  @override
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      log('🔐 Initializing auth service...');

      // Load session from storage
      await _loadSessionFromStorage();

      _isInitialized = true;

      if (isAuthenticated) {
        log('✅ User session found and loaded');
      } else {
        log('ℹ️ No active user session');
      }
    } catch (e) {
      log('❌ Failed to initialize auth service: $e');
      // Clear potentially corrupted data
      await clearSession();
    }
  }

  @override
  Future<void> saveSession(AuthToken authToken) async {
    try {
      log('💾 Saving user session...');

      // Save to SharedPreferences as single JSON object
      await _storage.setString(_authTokenKey, jsonEncode(authToken.toJson()));

      // Update public auth token
      this.authToken = authToken;

      log('✅ Session saved successfully');
    } catch (e) {
      log('❌ Failed to save session: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateTokens({required String accessToken, required String refreshToken}) async {
    try {
      log('🔄 Updating auth tokens...');

      if (authToken == null) {
        throw Exception('No existing session to update tokens');
      }

      // Create new AuthToken with updated tokens but same user
      final updatedAuthToken = authToken!.copyWithTokens(accessToken: accessToken, refreshToken: refreshToken);

      // Save to SharedPreferences
      await _storage.setString(_authTokenKey, jsonEncode(updatedAuthToken.toJson()));

      // Update public auth token
      authToken = updatedAuthToken;

      log('✅ Tokens updated successfully');
    } catch (e) {
      log('❌ Failed to update tokens: $e');
      rethrow;
    }
  }

  @override
  Future<void> clearSession() async {
    try {
      log('🗑️ Clearing user session...');

      // Clear from SharedPreferences
      await _storage.remove(_authTokenKey);

      // Clear public auth token
      authToken = null;

      log('✅ Session cleared successfully');
    } catch (e) {
      log('❌ Failed to clear session: $e');
      rethrow;
    }
  }

  @override
  Future<bool> hasStoredSession() async {
    try {
      return _storage.containsKey(_authTokenKey);
    } catch (e) {
      log('❌ Failed to check stored session: $e');
      return false;
    }
  }

  /// Load session from SharedPreferences to cache
  Future<void> _loadSessionFromStorage() async {
    try {
      final authTokenJson = _storage.getString(_authTokenKey);

      if (authTokenJson != null) {
        final authTokenMap = jsonDecode(authTokenJson) as Map<String, dynamic>;
        authToken = AuthToken.fromJson(authTokenMap);
      }
    } catch (e) {
      log('❌ Failed to load session from storage: $e');
      // Clear potentially corrupted data
      await clearSession();
    }
  }
}
