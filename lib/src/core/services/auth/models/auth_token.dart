import 'package:equatable/equatable.dart';

import 'user_model.dart';

/// Model representing authentication tokens and user data
class AuthToken extends Equatable {
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
  List<Object?> get props => [accessToken, refreshToken, user];
}
