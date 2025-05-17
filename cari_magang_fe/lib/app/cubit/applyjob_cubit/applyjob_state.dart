import 'package:equatable/equatable.dart';
import 'package:cari_magang_fe/data/models/applyjob_model/applyjob_model.dart';

class ApplyJobState extends Equatable {
  const ApplyJobState({
    this.applyjob = const ApplyjobModel(),
    this.error = '',
    this.isLoading = false,
    this.message = '',
    this.status = '',
    this.applySuccess = false,
  });

  final ApplyjobModel applyjob;
  final String error;
  final bool isLoading;
  final String message;
  final String status;
  final bool applySuccess;

  @override
  List<Object> get props => [
    applyjob,
    error,
    isLoading,
    applySuccess,
    message,
    status,
  ];

  ApplyJobState copyWith({
    ApplyjobModel? applyjob,
    String? error,
    bool? isLoading,
    String? message,
    String? status,
    bool? applySuccess,
  }) {
    return ApplyJobState(
      applyjob: applyjob ?? this.applyjob,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      status: status ?? this.status,
      applySuccess: applySuccess ?? this.applySuccess,
    );
  }
}
