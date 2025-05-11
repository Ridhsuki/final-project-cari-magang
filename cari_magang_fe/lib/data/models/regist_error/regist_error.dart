import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'errors.dart';

class RegistError extends Equatable {
  final String? message;
  final Errors? errors;

  const RegistError({this.message, this.errors});

  factory RegistError.fromMap(Map<String, dynamic> data) => RegistError(
    message: data['message'] as String?,
    errors:
        data['errors'] == null
            ? null
            : Errors.fromMap(data['errors'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'message': message,
    'errors': errors?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RegistError].
  factory RegistError.fromJson(String data) {
    return RegistError.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RegistError] to a JSON string.
  String toJson() => json.encode(toMap());

  RegistError copyWith({String? message, Errors? errors}) {
    return RegistError(
      message: message ?? this.message,
      errors: errors ?? this.errors,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [message, errors];
}
