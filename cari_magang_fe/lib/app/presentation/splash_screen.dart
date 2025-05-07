import 'package:cari_magang_fe/data/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cari_magang_fe/app/core/appcolors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      var token = LocalStorage.getToken();

      if (token != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/main');
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/getstarted');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Cari \nMagang',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Urbanist',
                color: Appcolors.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
