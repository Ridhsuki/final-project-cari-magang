import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'datum.dart';

class AppliedStatusModel extends Equatable {
  final String? status;
  final List<Datum>? data;

  const AppliedStatusModel({this.status, this.data});

  factory AppliedStatusModel.fromMap(Map<String, dynamic> data) {
    return AppliedStatusModel(
      status: data['status'] as String?,
      data:
          (data['data'] as List<dynamic>?)
              ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
    'status': status,
    'data': data?.map((e) => e.toMap()).toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AppliedStatusModel].
  factory AppliedStatusModel.fromJson(String data) {
    return AppliedStatusModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [AppliedStatusModel] to a JSON string.
  String toJson() => json.encode(toMap());

  AppliedStatusModel copyWith({String? status, List<Datum>? data}) {
    return AppliedStatusModel(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, data];
}
