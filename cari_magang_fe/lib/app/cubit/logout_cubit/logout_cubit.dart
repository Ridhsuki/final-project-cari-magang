import 'package:bloc/bloc.dart';
import 'package:cari_magang_fe/app/cubit/logout_cubit/logout_state.dart';
import 'package:cari_magang_fe/data/datasource/services/auth_service.dart';
import 'package:cari_magang_fe/data/local_storage/local_storage.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutState());

  Future<void> logout(String token) async {
    emit(state.copyWith(isLoading: true));

    var data = await AuthService().logout(token);

    data.fold(
      (left) {
        emit(state.copyWith(error: left));
      },
      (right) async {
        LocalStorage.removeToken();
        emit(state.copyWith(logoutResponse: right));
      },
    );

    emit(state.copyWith(isLoading: false));
  }

  void resetState() {
    emit(LogoutState());
  }
}
