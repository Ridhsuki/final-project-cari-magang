import 'package:cari_magang_fe/app/core/appcolors.dart';
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
        separatorBuilder: (context, index) => SizedBox(height: 8),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Appcolors.primaryColor.withAlpha((0.4 * 255).toInt()),
                  blurRadius: 1,
                  offset: Offset(0, 1), // Bayangan ke bawah
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 34,
                  height: 34,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: Image.network(
                      'https://magangapp.ridhsuki.my.id/storage/profile_pictures/idn.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    notifications[index],
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                    softWrap: true,
                  ),
                ),
                PopupMenuButton<String>(
                  borderRadius: BorderRadius.circular(24),
                  onSelected: (value) {
                    if (value == 'delete') {
                      // TODO: handle delete
                    } else if (value == 'read') {
                      // TODO: handle mark as read
                    }
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 'read',
                          child: Text('Mark as read'),
                        ),
                        PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                  icon: Icon(Icons.more_vert),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
