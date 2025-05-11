import 'dart:convert';

import 'package:equatable/equatable.dart';

class InternshipsError extends Equatable {
  final String? message;

  const InternshipsError({this.message});

  factory InternshipsError.fromMap(Map<String, dynamic> data) {
    return InternshipsError(message: data['message'] as String?);
  }

  Map<String, dynamic> toMap() => {'message': message};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [InternshipsError].
  factory InternshipsError.fromJson(String data) {
    return InternshipsError.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [InternshipsError] to a JSON string.
  String toJson() => json.encode(toMap());

  InternshipsError copyWith({String? message}) {
    return InternshipsError(message: message ?? this.message);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [message];
}
