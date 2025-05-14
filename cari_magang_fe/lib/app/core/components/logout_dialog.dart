import 'package:cari_magang_fe/app/cubit/logout_cubit/logout_state.dart';
import 'package:cari_magang_fe/app/cubit/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cari_magang_fe/app/core/appcolors.dart';
import 'package:cari_magang_fe/app/cubit/logout_cubit/logout_cubit.dart';
import 'package:cari_magang_fe/data/local_storage/local_storage.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (!state.isLoading) {
          Navigator.of(context).pop();
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
          onConfirm();
        }
      },
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFDF6F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 32,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.logout,
                size: 48,
                color: Appcolors.primaryColor,
              ),
              const SizedBox(height: 16),
              const Text(
                'Keluar dari akun?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Appcolors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Apakah Anda yakin ingin keluar dari akun ini?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Appcolors.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Batal',
                        style: TextStyle(color: Appcolors.primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed:
                          state.isLoading
                              ? null
                              : () async {
                                final token = LocalStorage.getToken();
                                if (token != null && token.isNotEmpty) {
                                  final logoutCubit =
                                      context.read<LogoutCubit>();
                                  final profileCubit =
                                      context.read<ProfileCubit>();
                                  await logoutCubit.logout(token);
                                  profileCubit.resetProfile();
                                  LocalStorage.removeToken();

                                  if (!context.mounted) return;
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/login',
                                    (route) => false,
                                  );
                                  onConfirm();
                                } else {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Token tidak tersedia.'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                      child:
                          state.isLoading
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                              : const Text(
                                'Keluar',
                                style: TextStyle(color: Colors.white),
                              ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}