import 'package:bloc/bloc.dart';
import 'package:cari_magang_fe/app/cubit/notif_cubit/notif_state.dart';
import 'package:cari_magang_fe/data/datasource/services/notif_service.dart';
import 'package:cari_magang_fe/data/models/delete_notif_model.dart';

class NotifCubit extends Cubit<NotifState> {
  NotifCubit() : super(NotifState());
  Future<void> getNotifications() async {
    emit(state.copyWith(isLoading: true));

    var data = await NotifService().getNotifications();

    data.fold((left) => emit(state.copyWith(error: left)), (right) {
      final data = right.data ?? [];
      final reversed = data.reversed.toList();
      emit(state.copyWith(notifData: reversed));
    });

    emit(state.copyWith(isLoading: false));
  }

  Future<void> deleteNotification(String id) async {
    final updatedList = List.of(state.notifData)
      ..removeWhere((n) => n.id == id);
    emit(state.copyWith(notifData: updatedList));

    emit(state.copyWith(isLoading: true));

    var data = await NotifService().deleteNotification(id);

    data.fold(
      (left) {
        emit(state.copyWith(error: left));
      },
      (right) {
        emit(state.copyWith(deleteNotif: right));
        getNotifications();
      },
    );

    emit(state.copyWith(isLoading: false));
  }

  void resetDeleteState() {
    emit(state.copyWith(deleteNotif: DeleteNotifModel()));
  }
}
