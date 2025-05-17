import 'package:cari_magang_fe/data/models/saved_model/datum.dart';
import 'package:equatable/equatable.dart';

class SavedState extends Equatable {
  const SavedState({
    this.savedInternship = const [],
    this.isLoading = false,
    this.error = '',
    this.message = ''
  });

  final List<Datum> savedInternship;
  final bool isLoading;
  final String error;
  final String message;

  @override
  List<Object> get props => [savedInternship, isLoading, error, message];

 SavedState copyWith({
    List<Datum>? savedInternship,
    bool? isLoading,
    String? error,
    String? message,
  }) {
    return SavedState(
      savedInternship: savedInternship ?? this.savedInternship,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }
}
