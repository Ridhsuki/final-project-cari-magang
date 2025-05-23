import 'package:bloc/bloc.dart';
import 'package:cari_magang_fe/app/cubit/login_cubit/login_state.dart';
import 'package:cari_magang_fe/data/datasource/services/auth_service.dart';
import 'package:cari_magang_fe/data/datasource/local_storage/local_storage.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

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
    emit(LoginState());
  }
}
