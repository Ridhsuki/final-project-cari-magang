import 'package:cari_magang_fe/app/presentation/main/home_screen.dart';
import 'package:cari_magang_fe/app/presentation/main/notif_screen.dart';
import 'package:cari_magang_fe/app/presentation/main/profile_screen.dart';
import 'package:cari_magang_fe/app/presentation/main/saved_screen.dart';
import 'package:cari_magang_fe/app/presentation/main/settings_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int posisiSaatIni = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[posisiSaatIni],
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: posisiSaatIni,
        onTap: (index) {
          setState(() {
            posisiSaatIni = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  List screen = [
    NotifScreen(),
    SavedScreen(),
    HomeScreen(),
    SettingsScreen(),
    ProfileScreen(),
  ];
}
