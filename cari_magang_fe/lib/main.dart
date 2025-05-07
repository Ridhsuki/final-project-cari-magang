import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cari_magang_fe/app/core/appcolors.dart';
import 'package:cari_magang_fe/app/presentation/getstarted_screen.dart';
import 'package:cari_magang_fe/app/presentation/login_screen.dart';
import 'package:cari_magang_fe/app/presentation/main_screen.dart';
import 'package:cari_magang_fe/app/presentation/register_screen.dart';
import 'package:cari_magang_fe/app/presentation/splash_screen.dart';
import 'package:cari_magang_fe/app/cubit/cubit/auth_cubit.dart';
import 'package:cari_magang_fe/data/local_storage/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init(); // Tambahkan ini agar Hive siap

  runApp(BlocProvider(create: (context) => AuthCubit(), child: const MyApp()));
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
        '/register': (context) => const RegisterScreen(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}
