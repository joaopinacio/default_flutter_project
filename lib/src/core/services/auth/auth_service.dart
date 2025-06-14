import 'models/auth_token.dart';
import 'models/user_model.dart';

/// Abstract interface for authentication service
abstract class IAuthService {
  /// Initialize the auth service and check for existing session
  Future<void> init();

  /// Save user session (AuthToken contains both tokens and user data)
  Future<void> saveSession(AuthToken authToken);

  /// Get current access token
  String? get accessToken;

  /// Get current refresh token
  String? get refreshToken;

  /// Get current user data
  UserModel? get currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated;

  /// Update only the tokens (useful for token refresh)
  void updateTokens({required String accessToken, required String refreshToken});

  /// Clear all session data (logout)
  Future<void> clearSession();

  /// Check if session exists in storage
  Future<bool> hasStoredSession();
}
