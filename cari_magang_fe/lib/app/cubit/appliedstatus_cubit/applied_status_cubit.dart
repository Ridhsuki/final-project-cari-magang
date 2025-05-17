import 'package:bloc/bloc.dart';
import 'package:cari_magang_fe/app/cubit/appliedstatus_cubit/applied_status_state.dart';
import 'package:cari_magang_fe/data/datasource/services/applied_status_service.dart';

class AppliedStatusCubit extends Cubit<AppliedStatusState> {
  AppliedStatusCubit() : super(AppliedStatusState());

  Future<void> getAppliedData() async {
    emit(state.copyWith(isLoading: true));

    var data = await AppliedStatusService().getAppliedHistory();

    data.fold(
      (left) {
        emit(state.copyWith(error: left));
      },
      (right) {
        final data = right.data ?? [];
        final reversed = data.reversed.toList();
        emit(state.copyWith(appliedInternship: reversed));
      },
    );
    emit(state.copyWith(isLoading: false));
  }
}
