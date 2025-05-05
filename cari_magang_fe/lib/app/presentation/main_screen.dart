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
            icon: Icon(Icons.notifications_none_rounded),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          ),
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
