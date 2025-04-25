import 'package:cari_magang_fe/app/core/components/assets_const.dart';
import 'package:flutter/material.dart';
import 'package:cari_magang_fe/app/core/components/appcolors.dart';

class GetstartedScreen extends StatelessWidget {
  const GetstartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.secondaryColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Image
          Positioned(
            bottom: -110,
            left: 0,
            right: 0,
            child: Image.asset(AssetsConst.officePT),
          ),
          // Orange Rectangle
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(AssetsConst.rectangleOrange),
          ),
          // Text content
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
                    fontSize: 48,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Magang',
                  style: TextStyle(
                    fontSize: 48,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Bersiap untuk memulai\nkarir besarmu',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Syne',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          // Get Started Button
          Positioned(
            bottom: 40,
            left: 30,
            right: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Get Started', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
