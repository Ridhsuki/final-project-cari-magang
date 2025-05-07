import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'data.dart';

class LoginResponse extends Equatable {
  final String? status;
  final String? message;
  final Data? data;

  const LoginResponse({this.status, this.message, this.data});

  factory LoginResponse.fromMap(Map<String, dynamic> data) => LoginResponse(
    status: data['status'] as String?,
    message: data['message'] as String?,
    data:
        data['data'] == null
            ? null
            : Data.fromMap(data['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'status': status,
    'message': message,
    'data': data?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginResponse].
  factory LoginResponse.fromJson(String data) {
    return LoginResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  LoginResponse copyWith({String? status, String? message, Data? data}) {
    return LoginResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, message, data];
}
