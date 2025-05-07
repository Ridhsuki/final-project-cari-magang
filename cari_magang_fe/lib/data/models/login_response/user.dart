import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final String? role;
  final String? profilePicture;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.role,
    this.profilePicture,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromMap(Map<String, dynamic> data) => User(
    id: data['id'] as int?,
    name: data['name'] as String?,
    email: data['email'] as String?,
    emailVerifiedAt: data['email_verified_at'] as dynamic,
    role: data['role'] as String?,
    profilePicture: data['profile_picture'] as String?,
    createdAt:
        data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
    updatedAt:
        data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'email_verified_at': emailVerifiedAt,
    'role': role,
    'profile_picture': profilePicture,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());

  User copyWith({
    int? id,
    String? name,
    String? email,
    dynamic emailVerifiedAt,
    String? role,
    String? profilePicture,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      role: role ?? this.role,
      profilePicture: profilePicture ?? this.profilePicture,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      emailVerifiedAt,
      role,
      profilePicture,
      createdAt,
      updatedAt,
    ];
  }
}
