import 'package:cari_magang_fe/data/models/delete_notif_model.dart';
import 'package:cari_magang_fe/data/models/notif_model/datum.dart';
import 'package:equatable/equatable.dart';

class NotifState extends Equatable {
  const NotifState({
    this.notifData = const [],
    this.deleteNotif = const DeleteNotifModel(),
    this.isLoading = false,
    this.error = '',
  });

  final List<Datum> notifData;
  final DeleteNotifModel deleteNotif;
  final bool isLoading;
  final String error;

  @override
  List<Object> get props => [notifData, deleteNotif, isLoading, error];

  NotifState copyWith({
    List<Datum>? notifData,
    DeleteNotifModel? deleteNotif,
    bool? isLoading,
    String? error,
  }) {
    return NotifState(
      notifData: notifData ?? this.notifData,
      deleteNotif: deleteNotif ?? this.deleteNotif,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
