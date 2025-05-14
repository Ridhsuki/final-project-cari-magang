import 'package:cari_magang_fe/data/models/logout_response.dart';
import 'package:equatable/equatable.dart';

class LogoutState extends Equatable {
  const LogoutState({
    this.logoutResponse = const LogoutResponse(),
    this.isLoading = false,
    this.error = '',
  });

  final LogoutResponse logoutResponse;
  final bool isLoading;
  final String error;

  @override
  List<Object> get props => [logoutResponse, isLoading, error];

  LogoutState copyWith({
    LogoutResponse? logoutResponse,
    bool? isLoading,
    String? error,
  }) {
    return LogoutState(
      logoutResponse: logoutResponse ?? this.logoutResponse,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
