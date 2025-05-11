import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'datum.dart';

class InternshipsModel extends Equatable {
  final String? status;
  final List<Datum>? data;

  const InternshipsModel({this.status, this.data});

  factory InternshipsModel.fromMap(Map<String, dynamic> data) {
    return InternshipsModel(
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
  /// Parses the string and returns the resulting Json object as [InternshipsModel].
  factory InternshipsModel.fromJson(String data) {
    return InternshipsModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [InternshipsModel] to a JSON string.
  String toJson() => json.encode(toMap());

  InternshipsModel copyWith({String? status, List<Datum>? data}) {
    return InternshipsModel(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, data];
}
