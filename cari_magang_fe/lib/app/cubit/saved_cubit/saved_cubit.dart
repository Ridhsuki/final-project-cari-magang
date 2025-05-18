import 'package:bloc/bloc.dart';
import 'package:cari_magang_fe/app/cubit/saved_cubit/saved_state.dart';
import 'package:cari_magang_fe/data/datasource/services/saved_service.dart';

class SavedCubit extends Cubit<SavedState> {
  SavedCubit() : super(SavedState());

  Future<void> getSavedData() async {
    emit(state.copyWith(isLoading: true));

    var data = await SavedService().getSaved();

    data.fold((left) => emit(state.copyWith(error: left)), (right) {
      final data = right.data ?? [];
      final reversed = data.reversed.toList();
      emit(state.copyWith(savedInternship: reversed));
    });

    emit(state.copyWith(isLoading: false));
  }

  Future<void> toggleSaved(int internshipId) async {
    emit(state.copyWith(isLoading: true));

    final result = await SavedService().updateSaved(internshipId);

    result.fold(
      (error) => emit(state.copyWith(error: error, isLoading: false)),
      (message) async {
        // Refresh data favorit setelah toggle berhasil
        await getSavedData();
        emit(state.copyWith(message: message, isLoading: false));
      },
    );
  }

  bool isSaved(int internshipId) {
    return state.savedInternship.any((item) => item.id == internshipId);
  }
}
