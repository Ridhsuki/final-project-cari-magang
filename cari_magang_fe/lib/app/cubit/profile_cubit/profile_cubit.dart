import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cari_magang_fe/app/cubit/profile_cubit/profile_state.dart';
import 'package:cari_magang_fe/data/datasource/services/profile_service.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  Future<void> getUser() async {
    emit(state.copyWith(isLoading: true));

    var data = await ProfileService().getUser();

    data.fold(
      (left) => emit(state.copyWith(error: left)),
      (right) => emit(state.copyWith(profile: right)),
    );

    emit(state.copyWith(isLoading: false));
  }

  Future<void> updateUser({
    required String name,
    required String placeOfBirth,
    required String dateOfBirth,
    required String address,
    required String education,
    File? profilePicture
  }) async {
    emit(state.copyWith(isLoading: true));

    final updateResult = await ProfileService().updateProfile(
      name: name,
      placeOfBirth: placeOfBirth,
      dateOfBirth: dateOfBirth,
      address: address,
      education: education,
      profilePicture: profilePicture
    );

    if (updateResult.isLeft) {
      emit(
        state.copyWith(
          isLoading: false,
          updateSuccess: false,
          message: updateResult.left,
        ),
      );
      return;
    }

    // Memuat ulang data setelah update
    final profileResult = await ProfileService().getUser();

    profileResult.fold(
      (error) => emit(
        state.copyWith(
          isLoading: false,
          updateSuccess: false,
          message: 'Profile updated, but failed to reload: $error',
        ),
      ),
      (profile) => emit(
        state.copyWith(
          isLoading: false,
          updateSuccess: true,
          profile: profile,
          message: 'Profile berhasil diperbarui!',
        ),
      ),
    );
  }
}
