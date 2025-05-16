import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'internship.dart';
import 'sender.dart';

class Datum extends Equatable {
  final String? id;
  final int? senderId;
  final int? receiverId;
  final int? internshipId;
  final String? type;
  final String? notifiableType;
  final int? notifiableId;
  final String? message;
  final int? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic readAt;
  final dynamic data;
  final Sender? sender;
  final Internship? internship;

  const Datum({
    this.id,
    this.senderId,
    this.receiverId,
    this.internshipId,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.message,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.readAt,
    this.data,
    this.sender,
    this.internship,
  });

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
    id: data['id'] as String?,
    senderId: data['sender_id'] as int?,
    receiverId: data['receiver_id'] as int?,
    internshipId: data['internship_id'] as int?,
    type: data['type'] as String?,
    notifiableType: data['notifiable_type'] as String?,
    notifiableId: data['notifiable_id'] as int?,
    message: data['message'] as String?,
    isRead: data['is_read'] as int?,
    createdAt:
        data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
    updatedAt:
        data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
    readAt: data['read_at'] as dynamic,
    data: data['data'] as dynamic,
    sender:
        data['sender'] == null
            ? null
            : Sender.fromMap(data['sender'] as Map<String, dynamic>),
    internship:
        data['internship'] == null
            ? null
            : Internship.fromMap(data['internship'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'sender_id': senderId,
    'receiver_id': receiverId,
    'internship_id': internshipId,
    'type': type,
    'notifiable_type': notifiableType,
    'notifiable_id': notifiableId,
    'message': message,
    'is_read': isRead,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'read_at': readAt,
    'data': data,
    'sender': sender?.toMap(),
    'internship': internship?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Datum.fromJson(String data) {
    return Datum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());

  Datum copyWith({
    String? id,
    int? senderId,
    int? receiverId,
    int? internshipId,
    String? type,
    String? notifiableType,
    int? notifiableId,
    String? message,
    int? isRead,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic readAt,
    dynamic data,
    Sender? sender,
    Internship? internship,
  }) {
    return Datum(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      internshipId: internshipId ?? this.internshipId,
      type: type ?? this.type,
      notifiableType: notifiableType ?? this.notifiableType,
      notifiableId: notifiableId ?? this.notifiableId,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      readAt: readAt ?? this.readAt,
      data: data ?? this.data,
      sender: sender ?? this.sender,
      internship: internship ?? this.internship,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      senderId,
      receiverId,
      internshipId,
      type,
      notifiableType,
      notifiableId,
      message,
      isRead,
      createdAt,
      updatedAt,
      readAt,
      data,
      sender,
      internship,
    ];
  }
}
