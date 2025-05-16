import 'dart:convert';

import 'package:equatable/equatable.dart';

class DeleteNotifModel extends Equatable {
  final String? status;
  final String? message;

  const DeleteNotifModel({this.status, this.message});

  factory DeleteNotifModel.fromMap(Map<String, dynamic> data) {
    return DeleteNotifModel(
      status: data['status'] as String?,
      message: data['message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {'status': status, 'message': message};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DeleteNotifModel].
  factory DeleteNotifModel.fromJson(String data) {
    return DeleteNotifModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DeleteNotifModel] to a JSON string.
  String toJson() => json.encode(toMap());

  DeleteNotifModel copyWith({String? status, String? message}) {
    return DeleteNotifModel(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, message];
}
