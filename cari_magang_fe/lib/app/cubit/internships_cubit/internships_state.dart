import 'package:cari_magang_fe/data/models/internships_model/datum.dart';
import 'package:cari_magang_fe/data/models/internships_model/internships_model.dart';
import 'package:equatable/equatable.dart';

class InternshipsState extends Equatable {
  const InternshipsState({
    this.internshipsData = const [],
    this.isLoading = false,
    this.error = '',
  });

  final List<Datum> internshipsData;
  final bool isLoading;
  final String error;

  @override
  List<Object> get props => [internshipsData, isLoading, error];

  InternshipsState copyWith({
    List<Datum>? internshipsData,
    bool? isLoading,
    String? error,
  }) {
    return InternshipsState(
      internshipsData: internshipsData ?? this.internshipsData,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
