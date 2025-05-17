import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'datum.dart';

class SavedModel extends Equatable {
  final String? status;
  final List<Datum>? data;

  const SavedModel({this.status, this.data});

  factory SavedModel.fromMap(Map<String, dynamic> data) => SavedModel(
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
  /// Parses the string and returns the resulting Json object as [SavedModel].
  factory SavedModel.fromJson(String data) {
    return SavedModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SavedModel] to a JSON string.
  String toJson() => json.encode(toMap());

  SavedModel copyWith({String? status, List<Datum>? data}) {
    return SavedModel(status: status ?? this.status, data: data ?? this.data);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, data];
}
