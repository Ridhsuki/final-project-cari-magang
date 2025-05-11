import 'package:bloc/bloc.dart';
import 'package:cari_magang_fe/app/cubit/regist_cubit/regist_state.dart';
import 'package:cari_magang_fe/data/datasource/services/auth_service.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState());

  Future<void> doRegister(String name, String email, String password) async {
    emit(state.copyWith(isLoading: true));

    var data = await AuthService().regist(name, email, password);

    data.fold(
      (left) {
        emit(state.copyWith(error: left));
      },
      (right) {
        emit(state.copyWith(registResponse: right));
      },
    );

    emit(state.copyWith(isLoading: false));
  }

  void resetState() {
    emit(RegisterState());
  }
}
