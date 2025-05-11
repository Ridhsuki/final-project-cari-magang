import 'package:equatable/equatable.dart';
import 'package:cari_magang_fe/data/models/login_response/login_response.dart';

class AuthState extends Equatable {
  const AuthState({
    this.loginResponse = const LoginResponse(),
    this.isLoading = false,
    this.error = '',
  });

  final LoginResponse loginResponse;
  final bool isLoading;
  final String error;

  @override
  List<Object> get props => [loginResponse, isLoading, error];

  AuthState copyWith({
    LoginResponse? loginResponse,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      loginResponse: loginResponse ?? this.loginResponse,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
