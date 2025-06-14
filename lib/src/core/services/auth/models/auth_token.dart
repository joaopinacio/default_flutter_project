import 'user_model.dart';

/// Model representing authentication tokens and user data
class AuthToken {
  const AuthToken({required this.accessToken, required this.refreshToken, required this.user});

  final String accessToken;
  final String refreshToken;
  final UserModel user;

  /// Create AuthToken from JSON
  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  /// Convert AuthToken to JSON
  Map<String, dynamic> toJson() {
    return {'accessToken': accessToken, 'refreshToken': refreshToken, 'user': user.toJson()};
  }

  /// Create a copy with updated values
  AuthToken copyWith({String? accessToken, String? refreshToken, UserModel? user}) {
    return AuthToken(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
    );
  }

  /// Create a copy with updated tokens only (keep same user)
  AuthToken copyWithTokens({required String accessToken, required String refreshToken}) {
    return AuthToken(accessToken: accessToken, refreshToken: refreshToken, user: user);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthToken &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.user == user;
  }

  @override
  int get hashCode => accessToken.hashCode ^ refreshToken.hashCode ^ user.hashCode;

  @override
  String toString() {
    return 'AuthToken(accessToken: ${accessToken.substring(0, 10)}..., refreshToken: ${refreshToken.substring(0, 10)}..., user: $user)';
  }
}
