import 'package:cari_magang_fe/app/core/appcolors.dart';
import 'package:cari_magang_fe/app/core/stringconst/assets_const.dart';
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
        selectedItemColor: Appcolors.primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: posisiSaatIni,
        onTap: (index) {
          setState(() {
            posisiSaatIni = index;
          });
        },
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        items: [
          BottomNavigationBarItem(
            activeIcon: Image.asset(AssetsConst.notifIconActive),
            icon: Image.asset(AssetsConst.notifIcon),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(AssetsConst.saveIconActive),
            icon: Image.asset(AssetsConst.saveIcon),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(AssetsConst.houseIconActive),
            icon: Image.asset(AssetsConst.houseIcon),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(AssetsConst.settingIconActive),
            icon: Image.asset(AssetsConst.settingIcon),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(AssetsConst.userIconActive),
            icon: Image.asset(AssetsConst.userIcon),
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
