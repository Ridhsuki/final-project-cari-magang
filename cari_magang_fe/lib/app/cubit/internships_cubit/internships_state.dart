import 'package:cari_magang_fe/data/models/internships_model/datum.dart';
import 'package:equatable/equatable.dart';

class InternshipsState extends Equatable {
  const InternshipsState({
    this.internshipsData = const [],
    this.filteredData = const [],
    this.isLoading = false,
    this.error = '',
  });

  final List<Datum> internshipsData;
  final List<Datum> filteredData;
  final bool isLoading;
  final String error;

  @override
  List<Object> get props => [internshipsData, filteredData, isLoading, error];

  InternshipsState copyWith({
    List<Datum>? internshipsData,
    List<Datum>? filteredData,
    bool? isLoading,
    String? error,
  }) {
    return InternshipsState(
      internshipsData: internshipsData ?? this.internshipsData,
      filteredData: filteredData ?? this.filteredData,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
