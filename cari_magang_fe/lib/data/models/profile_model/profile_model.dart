import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'data.dart';

class ProfileModel extends Equatable {
  final String? status;
  final Data? data;

  const ProfileModel({this.status, this.data});

  factory ProfileModel.fromMap(Map<String, dynamic> data) => ProfileModel(
    status: data['status'] as String?,
    data:
        data['data'] == null
            ? null
            : Data.fromMap(data['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {'status': status, 'data': data?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProfileModel].
  factory ProfileModel.fromJson(String data) {
    return ProfileModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProfileModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ProfileModel copyWith({String? status, Data? data}) {
    return ProfileModel(status: status ?? this.status, data: data ?? this.data);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, data];
}
