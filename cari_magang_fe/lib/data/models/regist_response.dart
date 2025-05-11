import 'dart:convert';

import 'package:equatable/equatable.dart';

class RegistResponse extends Equatable {
  final String? status;
  final String? message;

  const RegistResponse({this.status, this.message});

  factory RegistResponse.fromMap(Map<String, dynamic> data) {
    return RegistResponse(
      status: data['status'] as String?,
      message: data['message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {'status': status, 'message': message};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RegistResponse].
  factory RegistResponse.fromJson(String data) {
    return RegistResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RegistResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  RegistResponse copyWith({String? status, String? message}) {
    return RegistResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, message];
}
