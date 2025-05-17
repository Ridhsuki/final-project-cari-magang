import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'data.dart';

class ApplyjobModel extends Equatable {
  final String? status;
  final String? message;
  final Data? data;

  const ApplyjobModel({this.status, this.message, this.data});

  factory ApplyjobModel.fromMap(Map<String, dynamic> data) => ApplyjobModel(
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
  /// Parses the string and returns the resulting Json object as [ApplyjobModel].
  factory ApplyjobModel.fromJson(String data) {
    return ApplyjobModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ApplyjobModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ApplyjobModel copyWith({String? status, String? message, Data? data}) {
    return ApplyjobModel(
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
