import 'package:cari_magang_fe/app/core/components/appcolors.dart';
import 'package:cari_magang_fe/app/core/components/assets_const.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            top: -75,
            left: 0,
            right: 0,
            child: Image.asset(AssetsConst.rectangleOrange),
          ),

          // Teks "Cari Magang"
          Positioned(
            top: 280,
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
            top: 360,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 42,
                  vertical: 43,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Login with email address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
                        hintText: 'Email Address',
                        labelText: 'Email Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: const Icon(Icons.visibility),
                        hintText: 'Password',
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Checkbox(value: false, onChanged: null),
                            Text('Remember me', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        Flexible(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xffF66527),
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 68),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffF66527),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have an account? ",
                          style: TextStyle(fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Sign up",
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
        ],
      ),
    );
  }
}
