import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'datum.dart';

class NotifModel extends Equatable {
  final String? status;
  final List<Datum>? data;

  const NotifModel({this.status, this.data});

  factory NotifModel.fromMap(Map<String, dynamic> data) => NotifModel(
    status: data['status'] as String?,
    data:
        (data['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toMap() => {
    'status': status,
    'data': data?.map((e) => e.toMap()).toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NotifModel].
  factory NotifModel.fromJson(String data) {
    return NotifModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [NotifModel] to a JSON string.
  String toJson() => json.encode(toMap());

  NotifModel copyWith({String? status, List<Datum>? data}) {
    return NotifModel(status: status ?? this.status, data: data ?? this.data);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, data];
}
