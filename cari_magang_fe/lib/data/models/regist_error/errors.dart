import 'dart:convert';

import 'package:equatable/equatable.dart';

class Errors extends Equatable {
  final List<String>? email;

  const Errors({this.email});

  factory Errors.fromMap(Map<String, dynamic> data) =>
      Errors(email: data['email'] as List<String>?);

  Map<String, dynamic> toMap() => {'email': email};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Errors].
  factory Errors.fromJson(String data) {
    return Errors.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Errors] to a JSON string.
  String toJson() => json.encode(toMap());

  Errors copyWith({List<String>? email}) {
    return Errors(email: email ?? this.email);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [email];
}
