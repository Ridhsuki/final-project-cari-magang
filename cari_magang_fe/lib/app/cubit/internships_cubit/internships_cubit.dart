import 'package:bloc/bloc.dart';
import 'package:cari_magang_fe/app/cubit/internships_cubit/internships_state.dart';
import 'package:cari_magang_fe/data/datasource/services/internships_service.dart';

class InternshipsCubit extends Cubit<InternshipsState> {
  InternshipsCubit() : super(InternshipsState());

  Future<void> getInternships() async {
    emit(state.copyWith(isLoading: true, error: null));

    final response = await InternshipsService().getInternships();

    response.fold(
      (error) {
        emit(state.copyWith(isLoading: false, error: error));
      },
      (internshipsModel) {
        final data = internshipsModel.data ?? [];
        final reversed = data.reversed.toList();
        emit(state.copyWith(internshipsData: reversed, isLoading: false));
      },
    );
  }
}
