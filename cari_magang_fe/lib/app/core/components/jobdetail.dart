import 'package:cari_magang_fe/app/core/appcolors.dart';
import 'package:cari_magang_fe/app/cubit/saved_cubit/saved_cubit.dart';
import 'package:cari_magang_fe/app/cubit/saved_cubit/saved_state.dart';
import 'package:cari_magang_fe/app/presentation/main/insiders/applyjob_screen.dart';
import 'package:cari_magang_fe/app/cubit/appliedstatus_cubit/applied_status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class JobDetailWidget extends StatefulWidget {
  final int internshipId;
  final String title;
  final String category;
  final String location;
  final String system;
  final String status;
  final String name;
  final String description;

  const JobDetailWidget({
    super.key,
    required this.internshipId,
    required this.title,
    required this.category,
    required this.location,
    required this.system,
    required this.status,
    required this.name,
    required this.description,
  });

  @override
  State<JobDetailWidget> createState() => _JobDetailWidgetState();
}

class _JobDetailWidgetState extends State<JobDetailWidget> {
  bool isBookmarked = false;
  @override
  void initState() {
    super.initState();
    context.read<AppliedStatusCubit>().getAppliedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/banner.jpg',
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Appcolors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.category,
                        style: const TextStyle(
                          color: Appcolors.thirdColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Appcolors.fourthColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.location,
                            style: TextStyle(
                              color: Appcolors.thirdColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 16,
                            color: Appcolors.fourthColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.system,
                            style: TextStyle(
                              color: Appcolors.thirdColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.monetization_on,
                            size: 16,
                            color: Appcolors.fourthColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.status,
                            style: TextStyle(
                              color: Appcolors.thirdColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(height: 12),
                      Html(data: widget.description),
                      const SizedBox(height: 8),
                      const Divider(height: 32),
                      const SizedBox(height: 8),
                      Center(
                        child: SizedBox(
                          width: 180,
                          height: 38,
                          child: ElevatedButton(
                            onPressed: () {
                              final appliedInternships =
                                  context
                                      .read<AppliedStatusCubit>()
                                      .state
                                      .appliedInternship;

                              // Cek apakah internship sudah pernah di-apply
                              final alreadyApplied = appliedInternships.any(
                                (application) =>
                                    application.internship?.id ==
                                    widget.internshipId,
                              );

                              if (alreadyApplied) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Kamu sudah melamar pekerjaan ini. Tunggu notifikasi dari kami yaa.',
                                    ),
                                    backgroundColor: Appcolors.primaryColor,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11),
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => ApplyjobScreen(
                                          internshipId:
                                              widget.internshipId.toString(),
                                        ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolors.fourthColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text(
                              'Apply now',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Tombol back di kiri atas
          Positioned(
            top: 40,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black.withAlpha((0.2 * 255).toInt()),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Appcolors.thirdColor),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // Tombol bookmark di kanan atas
          BlocBuilder<SavedCubit, SavedState>(
            builder: (context, state) {
              final cubit = context.read<SavedCubit>();
              final isBookmarked = cubit.isSaved(widget.internshipId);
              return Positioned(
                top: 40,
                right: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.black.withAlpha((0.2 * 255).toInt()),
                  child: IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: Appcolors.fourthColor,
                    ),
                    onPressed: () async {
                      await context.read<SavedCubit>().toggleSaved(
                        widget.internshipId,
                      );
                      final isCurrentlyBookmarked = context
                          .read<SavedCubit>()
                          .isSaved(widget.internshipId);
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Appcolors.fourthColor,
                            content: Text(
                              isCurrentlyBookmarked
                                  ? 'Removed from saved'
                                  : 'Saved!',
                              style: TextStyle(
                                color: Appcolors.secondaryColor,
                                fontFamily: 'Inter',
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
