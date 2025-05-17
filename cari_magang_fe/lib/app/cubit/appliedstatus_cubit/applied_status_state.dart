import 'package:cari_magang_fe/data/models/applied_status_model/datum.dart';
import 'package:equatable/equatable.dart';

class AppliedStatusState extends Equatable {
  const AppliedStatusState({
    this.appliedInternship = const [],
    this.isLoading = false,
    this.error = '',
    this.message = '',
  });

  final List<Datum> appliedInternship;
  final bool isLoading;
  final String error;
  final String message;

  @override
  List<Object> get props => [appliedInternship, isLoading, error, message];

  AppliedStatusState copyWith({
    List<Datum>? appliedInternship,
    bool? isLoading,
    String? error,
    String? message,
  }) {
    return AppliedStatusState(
      appliedInternship: appliedInternship ?? this.appliedInternship,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }
}
