import 'dart:convert';

import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final int? id;
  final int? userId;
  final dynamic placeOfBirth;
  final dynamic dateOfBirth;
  final String? address;
  final dynamic phone;
  final dynamic education;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Profile({
    this.id,
    this.userId,
    this.placeOfBirth,
    this.dateOfBirth,
    this.address,
    this.phone,
    this.education,
    this.createdAt,
    this.updatedAt,
  });

  factory Profile.fromMap(Map<String, dynamic> data) => Profile(
    id: data['id'] as int?,
    userId: data['user_id'] as int?,
    placeOfBirth: data['place_of_birth'] as dynamic,
    dateOfBirth: data['date_of_birth'] as dynamic,
    address: data['address'] as String?,
    phone: data['phone'] as dynamic,
    education: data['education'] as dynamic,
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
    'user_id': userId,
    'place_of_birth': placeOfBirth,
    'date_of_birth': dateOfBirth,
    'address': address,
    'phone': phone,
    'education': education,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Profile].
  factory Profile.fromJson(String data) {
    return Profile.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Profile] to a JSON string.
  String toJson() => json.encode(toMap());

  Profile copyWith({
    int? id,
    int? userId,
    dynamic placeOfBirth,
    dynamic dateOfBirth,
    String? address,
    dynamic phone,
    dynamic education,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Profile(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      education: education ?? this.education,
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
      userId,
      placeOfBirth,
      dateOfBirth,
      address,
      phone,
      education,
      createdAt,
      updatedAt,
    ];
  }
}
