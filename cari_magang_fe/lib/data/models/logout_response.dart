import 'dart:convert';

import 'package:equatable/equatable.dart';

class LogoutResponse extends Equatable {
  final String? status;
  final String? message;

  const LogoutResponse({this.status, this.message});

  factory LogoutResponse.fromMap(Map<String, dynamic> data) {
    return LogoutResponse(
      status: data['status'] as String?,
      message: data['message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {'status': status, 'message': message};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LogoutResponse].
  factory LogoutResponse.fromJson(String data) {
    return LogoutResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LogoutResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  LogoutResponse copyWith({String? status, String? message}) {
    return LogoutResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, message];
}
