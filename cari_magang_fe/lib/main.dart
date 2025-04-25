import 'package:cari_magang_fe/app/core/components/appcolors.dart';
import 'package:cari_magang_fe/app/presentation/getstarted_screen.dart';
import 'package:cari_magang_fe/app/presentation/register_screen.dart';
import 'package:cari_magang_fe/app/presentation/splash_screen.dart';
import 'package:cari_magang_fe/app/presentation/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Appcolors.primaryColor),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/getstarted': (context) => const GetstartedScreen(),
        '/login': (context) => const LoginScreen(),
        '/Register': (context) => const RegisterScreen(),
      },
    );
  }
}
