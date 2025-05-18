import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'internship.dart';

class Datum extends Equatable {
  final int? id;
  final Internship? internship;
  final String? cv;
  final dynamic certificate;
  final String? status;
  final String? fullName;
  final String? dateOfBirth;
  final String? address;
  final String? education;
  final DateTime? appliedAt;

  const Datum({
    this.id,
    this.internship,
    this.cv,
    this.certificate,
    this.status,
    this.fullName,
    this.dateOfBirth,
    this.address,
    this.education,
    this.appliedAt,
  });

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
    id: data['id'] as int?,
    internship:
        data['internship'] == null
            ? null
            : Internship.fromMap(data['internship'] as Map<String, dynamic>),
    cv: data['cv'] as String?,
    certificate: data['certificate'] as dynamic,
    status: data['status'] as String?,
    fullName: data['full_name'] as String?,
    dateOfBirth: data['date_of_birth'] as String?,
    address: data['address'] as String?,
    education: data['education'] as String?,
    appliedAt:
        data['applied_at'] == null
            ? null
            : DateTime.parse(data['applied_at'] as String),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'internship': internship?.toMap(),
    'cv': cv,
    'certificate': certificate,
    'status': status,
    'full_name': fullName,
    'date_of_birth': dateOfBirth,
    'address': address,
    'education': education,
    'applied_at': appliedAt?.toIso8601String(),
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
    Internship? internship,
    String? cv,
    dynamic certificate,
    String? status,
    String? fullName,
    String? dateOfBirth,
    String? address,
    String? education,
    DateTime? appliedAt,
  }) {
    return Datum(
      id: id ?? this.id,
      internship: internship ?? this.internship,
      cv: cv ?? this.cv,
      certificate: certificate ?? this.certificate,
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      education: education ?? this.education,
      appliedAt: appliedAt ?? this.appliedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      internship,
      cv,
      certificate,
      status,
      fullName,
      dateOfBirth,
      address,
      education,
      appliedAt,
    ];
  }
}
