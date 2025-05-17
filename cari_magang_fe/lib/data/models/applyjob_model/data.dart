import 'dart:convert';

import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final int? id;
  final int? userId;
  final String? internshipId;
  final String? cv;
  final dynamic certificate;
  final String? status;
  final String? fullName;
  final String? dateOfBirth;
  final String? address;
  final String? education;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Data({
    this.id,
    this.userId,
    this.internshipId,
    this.cv,
    this.certificate,
    this.status,
    this.fullName,
    this.dateOfBirth,
    this.address,
    this.education,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    id: data['id'] as int?,
    userId: data['user_id'] as int?,
    internshipId: data['internship_id'] as String?,
    cv: data['cv'] as String?,
    certificate: data['certificate'] as dynamic,
    status: data['status'] as String?,
    fullName: data['full_name'] as String?,
    dateOfBirth: data['date_of_birth'] as String?,
    address: data['address'] as String?,
    education: data['education'] as String?,
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
    'internship_id': internshipId,
    'cv': cv,
    'certificate': certificate,
    'status': status,
    'full_name': fullName,
    'date_of_birth': dateOfBirth,
    'address': address,
    'education': education,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
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
    int? userId,
    String? internshipId,
    String? cv,
    dynamic certificate,
    String? status,
    String? fullName,
    String? dateOfBirth,
    String? address,
    String? education,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Data(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      internshipId: internshipId ?? this.internshipId,
      cv: cv ?? this.cv,
      certificate: certificate ?? this.certificate,
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
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
      internshipId,
      cv,
      certificate,
      status,
      fullName,
      dateOfBirth,
      address,
      education,
      createdAt,
      updatedAt,
    ];
  }
}
