import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cari_magang_fe/app/cubit/applyjob_cubit/applyjob_state.dart';
import 'package:cari_magang_fe/data/datasource/services/applyjob_service.dart';

class ApplyJobCubit extends Cubit<ApplyJobState> {
  ApplyJobCubit() : super(const ApplyJobState());

  Future<void> applyJob({
    required String internshipId,
    required File cv,
    required String fullName,
    required String dateOfBirth,
    required String address,
    required String education,
    File? certificate,
  }) async {
    emit(state.copyWith(isLoading: true));
    log('apply job cubit working');
    final result = await ApplyjobService().applyJob(
      internshipId: internshipId,
      cv: cv,
      fullName: fullName,
      dateOfBirth: dateOfBirth,
      address: address,
      education: education,
      certificate: certificate,
    );

    log('${result.isLeft}left');
    log('${result.isRight}right');

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          error: failure,
          applySuccess: false,
          message: 'Gagal melamar: $failure',
        ),
      ),
      (data) => emit(
        state.copyWith(
          isLoading: false,
          applyjob: data,
          // applySuccess: true,
          message: data.message ?? 'Berhasil melamar',
        ),
      ),
    );
  }

  void resetApplyJob() {
    emit(const ApplyJobState());
  }
}
