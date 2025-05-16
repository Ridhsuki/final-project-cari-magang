import 'dart:convert';

import 'package:equatable/equatable.dart';

class Internship extends Equatable {
  final int? id;
  final int? userId;
  final String? title;
  final String? description;
  final String? location;
  final int? categoryId;
  final String? status;
  final String? system;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Internship({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.location,
    this.categoryId,
    this.status,
    this.system,
    this.createdAt,
    this.updatedAt,
  });

  factory Internship.fromMap(Map<String, dynamic> data) => Internship(
    id: data['id'] as int?,
    userId: data['user_id'] as int?,
    title: data['title'] as String?,
    description: data['description'] as String?,
    location: data['location'] as String?,
    categoryId: data['category_id'] as int?,
    status: data['status'] as String?,
    system: data['system'] as String?,
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
    'title': title,
    'description': description,
    'location': location,
    'category_id': categoryId,
    'status': status,
    'system': system,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Internship].
  factory Internship.fromJson(String data) {
    return Internship.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Internship] to a JSON string.
  String toJson() => json.encode(toMap());

  Internship copyWith({
    int? id,
    int? userId,
    String? title,
    String? description,
    String? location,
    int? categoryId,
    String? status,
    String? system,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Internship(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      categoryId: categoryId ?? this.categoryId,
      status: status ?? this.status,
      system: system ?? this.system,
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
      title,
      description,
      location,
      categoryId,
      status,
      system,
      createdAt,
      updatedAt,
    ];
  }
}
