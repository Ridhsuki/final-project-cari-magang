import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'user.dart';

class Data extends Equatable {
  final String? token;
  final User? user;

  const Data({this.token, this.user});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    token: data['token'] as String?,
    user:
        data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {'token': token, 'user': user?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({String? token, User? user}) {
    return Data(token: token ?? this.token, user: user ?? this.user);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [token, user];
}
