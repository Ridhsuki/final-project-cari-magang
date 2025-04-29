import 'package:flutter/material.dart';

class NotifScreen extends StatelessWidget {
  final List<String> notifications = [
    'Efisery.com, Terima kasih telah melamar posisi [Nama Posisi] di eFishery. Kami sangat menghargai minat dan waktu yang telah Anda luangkan untuk...',
    'DX Studio.lookup, Terima kasih telah melamar posisi 3D Designer di eFishery. Kami sangat menghargai minat dan waktu yang telah Anda luangkan untuk...',
    'DesignGraph.co.id, Terima kasih telah melamar posisi UX Researcher. Kami sangat menghargai minat dan waktu yang telah Anda luangkan untuk...',
  ];

  NotifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Notification',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              notifications[index],
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          );
        },
      ),
    );
  }
}
