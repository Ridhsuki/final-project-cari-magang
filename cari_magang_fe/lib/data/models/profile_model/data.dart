import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'profile.dart';

class Data extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? profilePicture;
  final String? role;
  final Profile? profile;

  const Data({
    this.id,
    this.name,
    this.email,
    this.profilePicture,
    this.role,
    this.profile,
  });

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    id: data['id'] as int?,
    name: data['name'] as String?,
    email: data['email'] as String?,
    profilePicture: data['profile_picture'] as String?,
    role: data['role'] as String?,
    profile:
        data['profile'] == null
            ? null
            : Profile.fromMap(data['profile'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'profile_picture': profilePicture,
    'role': role,
    'profile': profile?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    int? id,
    String? name,
    String? email,
    String? profilePicture,
    String? role,
    Profile? profile,
  }) {
    return Data(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      role: role ?? this.role,
      profile: profile ?? this.profile,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, name, email, profilePicture, role, profile];
  }
}
