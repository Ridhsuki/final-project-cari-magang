import 'package:cari_magang_fe/app/core/appcolors.dart';
import 'package:cari_magang_fe/app/core/stringconst/assets_const.dart';
import 'package:cari_magang_fe/app/presentation/main/insiders/applyjob_screen.dart';
import 'package:flutter/material.dart';

class JobDetailWidget extends StatefulWidget {
  final String title;
  final String category;
  final String location;
  final String system;
  final String status;
  final String name;
  final String description;

  const JobDetailWidget({
    super.key,
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
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // const Icon(Icons.school, size: 16),
                          // const SizedBox(width: 4),
                          // Text(widget.qualification),
                          // const SizedBox(width: 12),
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Appcolors.fourthColor,
                          ),
                          const SizedBox(width: 4),
                          Text(widget.location),
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
                          Text(widget.system),
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
                          Text(widget.status),
                        ],
                      ),
                      const Divider(height: 32),
                      // Text(
                      //   widget.company,
                      //   style: const TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 16,
                      //   ),
                      // ),
                      // Text(widget.recruiter),
                      // const SizedBox(height: 24),
                      // const Text(
                      //   'Deskripsi Pekerjaan',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 16,
                      //     color: Colors.orange,
                      //   ),
                      // ),
                      const SizedBox(height: 8),
                      Text(widget.description),
                      const SizedBox(height: 8),
                      // BulletList(items: widget.duties),
                      const SizedBox(height: 24),
                      // const Text(
                      //   'Persyaratan',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 16,
                      //     color: Colors.orange,
                      //   ),
                      // ),
                      const SizedBox(height: 8),
                      // BulletList(items: widget.requirements),
                      const SizedBox(height: 24),
                      Center(
                        child: SizedBox(
                          width: 180,
                          height: 38,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ApplyjobScreen(),
                                ),
                              );
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
                              style: TextStyle(color: Colors.white),
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
                icon: const Icon(
                  Icons.arrow_back,
                  color: Appcolors.fourthColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // Tombol bookmark di kanan atas
          Positioned(
            top: 40,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black.withAlpha((0.2 * 255).toInt()),
              child: IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: Appcolors.fourthColor,
                ),
                onPressed: () {
                  setState(() {
                    isBookmarked = !isBookmarked;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isBookmarked ? 'Saved!' : 'Removed from saved',
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
