import 'package:cari_magang_fe/data/models/profile_model/profile_model.dart';
import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.profile = const ProfileModel(),
    this.error = '',
    this.isLoading = false,
    this.message = '',
    this.updateSuccess = false,
  });

  final ProfileModel profile;
  final String error;
  final bool isLoading;
  final String message;
  final bool updateSuccess;

  @override
  List<Object> get props => [profile, error, isLoading];
  ProfileState copyWith({
    ProfileModel? profile,
    bool? isLoading,
    String? error,
    String? message,
    bool? updateSuccess,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      updateSuccess: updateSuccess ?? this.updateSuccess,
    );
  }
}
