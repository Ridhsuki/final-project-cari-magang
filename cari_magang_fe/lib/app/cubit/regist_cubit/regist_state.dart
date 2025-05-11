import 'package:cari_magang_fe/data/models/regist_response.dart';
import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.registResponse = const RegistResponse(),
    this.isLoading = false,
    this.error = '',
  });

  final RegistResponse registResponse;
  final bool isLoading;
  final String error;

  @override
  List<Object> get props => [registResponse, isLoading, error];

  RegisterState copyWith({
    RegistResponse? registResponse,
    bool? isLoading,
    String? error,
  }) {
    return RegisterState(
      registResponse: registResponse ?? this.registResponse,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
