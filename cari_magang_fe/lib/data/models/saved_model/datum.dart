import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'category.dart';
import 'user.dart';

class Datum extends Equatable {
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
  final Category? category;
  final User? user;

  const Datum({
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
    this.category,
    this.user,
  });

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
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
    category:
        data['category'] == null
            ? null
            : Category.fromMap(data['category'] as Map<String, dynamic>),
    user:
        data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
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
    'category': category?.toMap(),
    'user': user?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Datum.fromJson(String data) {
    return Datum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());

  Datum copyWith({
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
    Category? category,
    User? user,
  }) {
    return Datum(
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
      category: category ?? this.category,
      user: user ?? this.user,
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
      category,
      user,
    ];
  }
}
