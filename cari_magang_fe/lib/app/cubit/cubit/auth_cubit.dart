import 'package:bloc/bloc.dart';
import 'package:cari_magang_fe/app/cubit/cubit/auth_state.dart';
import 'package:cari_magang_fe/data/datasource/services/auth_service.dart';
import 'package:cari_magang_fe/data/local_storage/local_storage.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  Future<void> doLogin(String email, String password) async {
    emit(state.copyWith(isLoading: true));

    var data = await AuthService().login(email, password);

    data.fold(
      (left) {
        emit(state.copyWith(error: left));
      },
      (right) {
        emit(state.copyWith(loginResponse: right));
        LocalStorage.saveToken(right.data?.token ?? '');
      },
    );

    emit(state.copyWith(isLoading: false));
  }

  void resetState() {
    emit(AuthState());
  }
}
