import 'package:cari_magang_fe/app/cubit/regist_cubit/regist_cubit.dart';
import 'package:cari_magang_fe/app/cubit/regist_cubit/regist_state.dart';
import 'package:flutter/material.dart';
import 'package:cari_magang_fe/app/core/appcolors.dart';
import 'package:cari_magang_fe/app/core/stringconst/assets_const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void handleRegister() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    confirmPasswordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      context.read<RegisterCubit>().doRegister(name, email, password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text(
            'Tidak boleh ada yang kosong',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen:
          (previous, current) =>
              current.registResponse != previous.registResponse ||
              current.error != previous.error,
      listener: (context, state) {
        if (state.registResponse.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              content: Text(
                state.registResponse.message ?? 'Register berhasil',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
          Navigator.pushReplacementNamed(context, '/login');
          context.read<RegisterCubit>().resetState();
        }

        if (state.error != '') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Text(
                state.error,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
          context.read<RegisterCubit>().resetState();
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Stack(
          children: [
            // Background image dan dekorasi
            Positioned(
              top: 45,
              left: 0,
              right: 0,
              child: Image.asset(AssetsConst.officePT),
            ),
            Positioned(
              top: -175,
              left: 0,
              right: 0,
              child: Image.asset(AssetsConst.rectangleOrange),
            ),

            // Teks "Cari Magang"
            Positioned(
              top: 180,
              left: 30,
              right: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Cari Magang',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold,
                      color: Appcolors.secondaryColor,
                    ),
                  ),
                  // SizedBox(height: 3),
                  Text(
                    'Bersiap untuk memulai karir besarmu',
                    style: TextStyle(
                      fontSize: 13,
                      color: Appcolors.secondaryColor,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),

            // Form putih (ClipRRect)
            Positioned(
              top: 260,
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                child: Container(
                  color: Color(0xffffffff),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 42,
                      vertical: 43,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Register with email address',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_outlined),
                            hintText: 'Name',
                            labelText: 'Name',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Appcolors.primaryColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Appcolors.primaryColor.withValues(alpha: 0.5),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined),
                            hintText: 'Email Address',
                            labelText: 'Email Address',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Appcolors.primaryColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Appcolors.primaryColor.withValues(alpha: 0.5),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: const Icon(Icons.visibility),
                            hintText: 'Password',
                            labelText: 'Password',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Appcolors.primaryColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Appcolors.primaryColor.withValues(alpha: 0.5),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: const Icon(Icons.visibility),
                            hintText: 'ConfirmPassword',
                            labelText: 'Confirm Password',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Appcolors.primaryColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Appcolors.primaryColor.withValues(alpha: 0.5),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 98),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: handleRegister,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffF66527),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Have an account? ",
                              style: TextStyle(fontSize: 12),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Color(0xffF66527),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
