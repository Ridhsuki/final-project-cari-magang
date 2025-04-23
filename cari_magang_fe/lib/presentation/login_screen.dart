import 'package:cari_magang_fe/components/assets_const.dart';
import 'package:flutter/material.dart';
import 'package:cari_magang_fe/components/appcolors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.secondaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Gambar pertama, diturunkan pakai Positioned
                Positioned(
                  bottom: -110, // <- Gambar jadi turun ke bawah
                  left: 0,
                  right: 0,
                  child: Image.asset(AssetsConst.officePT),
                ),
                // Gambar kedua tetap seperti biasa
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset(AssetsConst.rectangleOrange),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 30,
                  right: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Cari',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Magang',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Bersiap untuk memulai\nkarir besarmu',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
