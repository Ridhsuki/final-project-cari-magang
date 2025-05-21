import 'package:cari_magang_fe/app/core/appcolors.dart';
import 'package:cari_magang_fe/app/core/components/jobdetail.dart';
import 'package:cari_magang_fe/app/cubit/saved_cubit/saved_cubit.dart';
import 'package:cari_magang_fe/app/cubit/saved_cubit/saved_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SavedCubit>().getSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Saved',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
            fontFamily: 'Urbanist',
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<SavedCubit, SavedState>(
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

          if (state.savedInternship.isEmpty) {
            return const Center(child: Text('Belum ada data favorite.'));
          }

          return ListView.builder(
            itemCount: state.savedInternship.length,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemBuilder: (context, index) {
              final job = state.savedInternship[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => JobDetailWidget(
                            internshipId: job.id ?? 0,
                            title: job.title ?? '-',
                            category: job.category?.name ?? '-',
                            location: job.location ?? '-',
                            system: job.system ?? '-',
                            status: job.status ?? '-',
                            name: job.user?.name ?? '-',
                            description: job.description ?? '-',
                          ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          color: Appcolors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        job.user?.name ?? 'null',
                        style: TextStyle(
                          color: Appcolors.thirdColor,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        job.location!,
                        style: TextStyle(
                          color: Appcolors.thirdColor,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${job.system} | ${job.status!}',
                        style: TextStyle(
                          color: Appcolors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
