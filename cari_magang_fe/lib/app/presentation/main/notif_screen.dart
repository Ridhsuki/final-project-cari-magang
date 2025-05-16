import 'package:cari_magang_fe/app/core/appcolors.dart';
import 'package:cari_magang_fe/app/cubit/notif_cubit/notif_cubit.dart';
import 'package:cari_magang_fe/app/cubit/notif_cubit/notif_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotifScreen extends StatefulWidget {
  const NotifScreen({super.key});

  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotifCubit>().getNotifications();
  }

  String buildProfilePictureUrl(String? path) {
    if (path == null || path.isEmpty) {
      return 'https://magangapp.ridhsuki.my.id/storage/public/profile_pictures/default.png';
    }
    if (path.startsWith('http')) return path;
    return 'https://magangapp.ridhsuki.my.id/storage/public/profile_pictures/$path';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotifCubit, NotifState>(
      listenWhen: (previous, current) =>
          previous.deleteNotif != current.deleteNotif,
      listener: (context, state) {
        if (state.deleteNotif.message != null) {
          // Show snackbar upon successful deletion
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              content: Text('Notifikasi berhasil dihapus'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          );

          // Reset delete state
          context.read<NotifCubit>().resetDeleteState();
        } else if (state.error.isNotEmpty) {
          // Show error if deletion failed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Notification',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<NotifCubit, NotifState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.deepOrange),
              );
            }

            if (state.error.isNotEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Error: ${state.error}',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (state.notifData.isEmpty) {
              return const Center(child: Text('Belum ada Notifikasi.'));
            }

            return ListView.separated(
              itemCount: state.notifData.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final notif = state.notifData[index];
                final imageUrl = buildProfilePictureUrl(notif.sender?.profilePicture);

                return SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Appcolors.primaryColor.withAlpha((0.4 * 255).toInt()),
                          blurRadius: 1,
                          offset: const Offset(0, 1),
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
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "${notif.sender?.name}, ${notif.message.toString()}",
                            style: TextStyle(fontSize: 12, color: Colors.black87),
                            softWrap: true,
                          ),
                        ),
                        PopupMenuButton<String>(
                          tooltip: 'delete notification',
                          borderRadius: BorderRadius.circular(50),
                          onSelected: (value) async {
                            if (value == 'delete') {
                              final id = notif.id;
                              if (id != null) {
                                await context.read<NotifCubit>().deleteNotification(id);
                              }
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              height: 20,
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ],
                          icon: const Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
