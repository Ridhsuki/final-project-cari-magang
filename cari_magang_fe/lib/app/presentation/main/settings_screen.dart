import 'package:cari_magang_fe/app/core/components/logout_dialog.dart';
import 'package:cari_magang_fe/app/presentation/main/insiders/help_screen.dart';
import 'package:cari_magang_fe/app/presentation/main/insiders/jobapplied_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Title
            const Center(
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Urbanist',
                ),
              ),
            ),

            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => JobappliedScreen()),
                );
              },
              child: _buildSettingsItem('Status Lamaran'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HelpScreen()),
                );
              },
              child: _buildSettingsItem('Help & Support'),
            ),
            _buildSettingsItem('Change Password'),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (_) => LogoutDialog(
                        onConfirm: () {
                          // Logika logout atau navigasi ke login
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      ),
                );
              },
              child: _buildSettingsItem('Log Out'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFFEEFE7),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
