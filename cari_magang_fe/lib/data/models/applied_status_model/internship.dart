import 'dart:convert';

import 'package:equatable/equatable.dart';

class Internship extends Equatable {
  final int? id;
  final String? title;
  final String? company;

  const Internship({this.id, this.title, this.company});

  factory Internship.fromMap(Map<String, dynamic> data) => Internship(
    id: data['id'] as int?,
    title: data['title'] as String?,
    company: data['company'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'company': company,
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

  Internship copyWith({int? id, String? title, String? company}) {
    return Internship(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, title, company];
}
