import 'package:equatable/equatable.dart';

/// Model representing a user
class UserModel extends Equatable {
  const UserModel({required this.id, required this.name, required this.email});

  final String id;
  final String name;
  final String email;

  /// Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'] as String, name: json['name'] as String, email: json['email'] as String);
  }

  /// Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }

  /// Create a copy with updated values
  UserModel copyWith({String? id, String? name, String? email}) {
    return UserModel(id: id ?? this.id, name: name ?? this.name, email: email ?? this.email);
  }

  @override
  List<Object?> get props => [id, name, email];
}
