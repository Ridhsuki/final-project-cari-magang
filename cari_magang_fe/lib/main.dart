import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cari_magang_fe/app/cubit/applyjob_cubit/applyjob_cubit.dart';
import 'package:cari_magang_fe/app/cubit/appliedstatus_cubit/applied_status_cubit.dart';
import 'package:cari_magang_fe/app/cubit/internships_cubit/internships_cubit.dart';
import 'package:cari_magang_fe/app/cubit/logout_cubit/logout_cubit.dart';
import 'package:cari_magang_fe/app/cubit/notif_cubit/notif_cubit.dart';
import 'package:cari_magang_fe/app/cubit/regist_cubit/regist_cubit.dart';
import 'package:cari_magang_fe/app/cubit/profile_cubit/profile_cubit.dart';
import 'package:cari_magang_fe/app/cubit/login_cubit/login_cubit.dart';
import 'package:cari_magang_fe/app/cubit/saved_cubit/saved_cubit.dart';
import 'package:cari_magang_fe/app/presentation/getstarted_screen.dart';
import 'package:cari_magang_fe/app/presentation/login_screen.dart';
import 'package:cari_magang_fe/app/presentation/main_screen.dart';
import 'package:cari_magang_fe/app/presentation/register_screen.dart';
import 'package:cari_magang_fe/app/presentation/splash_screen.dart';
import 'package:cari_magang_fe/data/datasource/local_storage/local_storage.dart';

import 'package:cari_magang_fe/app/core/appcolors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => RegisterCubit()),
        BlocProvider(create: (_) => LogoutCubit()),
        BlocProvider(create: (_) => ProfileCubit()..getUser()),
        BlocProvider(create: (_) => InternshipsCubit()..getInternships()),
        BlocProvider(create: (_) => NotifCubit()..getNotifications()),
        BlocProvider(create: (_) => SavedCubit()..getSavedData())
        BlocProvider(create: (_) => SavedCubit()..getSavedData()),
        BlocProvider(create: (_) => AppliedStatusCubit()..getAppliedData()),
        BlocProvider(
          create:
              (_) =>
                  ApplyJobCubit()..applyJob(
                    internshipId: '',
                    cv: File(''),
                    fullName: '',
                    dateOfBirth: '',
                    address: '',
                    education: '',
                  ),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
