import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginError extends Equatable {
  final String? status;
  final String? message;

  const LoginError({this.status, this.message});

  factory LoginError.fromMap(Map<String, dynamic> data) => LoginError(
    status: data['status'] as String?,
    message: data['message'] as String?,
  );

  Map<String, dynamic> toMap() => {'status': status, 'message': message};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginError].
  factory LoginError.fromJson(String data) {
    return LoginError.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginError] to a JSON string.
  String toJson() => json.encode(toMap());

  LoginError copyWith({String? status, String? message}) {
    return LoginError(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, message];
}
