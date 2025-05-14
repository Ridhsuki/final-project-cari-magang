import 'package:cari_magang_fe/app/core/components/jobcard.dart';
import 'package:cari_magang_fe/app/core/stringconst/assets_const.dart';
import 'package:cari_magang_fe/app/presentation/main/insiders/jobdetail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header - Tidak scrollable
              const Center(
                child: Text(
                  'ALDO FERNAN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    fontFamily: 'Urbanist',
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(AssetsConst.searchIcon),
                        hintText: 'Search...',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.black, width: 3),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      Image.asset(AssetsConst.filterIcon),
                      Text('Filter', style: TextStyle(fontSize: 11)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Chart
                      Center(
                        child: Container(
                          height: 177,
                          width: 334,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.5),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: Offset(
                                  0,
                                  3,
                                ), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Center(child: Text('Chart Placeholder')),
                        ),
                      ),
                      const SizedBox(height: 30),

                      const Text(
                        'Terbaru',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Urbanist',
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Job list
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => JobDetailScreen(
                                          job: {
                                            'title': 'UI/UX Designer',
                                            'salary': 'Rp. 2,000,000 / month',
                                            'qualification': 'Fresh Graduate',
                                            'location': 'Semarang',
                                            'workplace':
                                                index % 2 == 0
                                                    ? 'On site'
                                                    : 'Remote',
                                            'salaryType':
                                                index % 2 == 0
                                                    ? 'Paid'
                                                    : 'Unpaid',
                                            'submission': 'Lamar Dengan CV',
                                            'company': 'PT. Jaya Makmur',
                                            'recruiter':
                                                'Rekruter - Bagas\nAktif 2 menit yang lalu',
                                            'description':
                                                'Sebagai Desainer UI/UX, Anda akan bertanggung jawab...',
                                            'duties': [
                                              'Mengembangkan konsep desain sesuai kebutuhan pengguna.',
                                              'Membuat wireframes, mockups, dan prototype.',
                                              'Melakukan riset pengguna dan uji kegunaan.',
                                              'Berkoordinasi dengan tim dev untuk implementasi.',
                                              'Menyelesaikan masalah desain UI dan memberikan solusi kreatif.',
                                              'Menyajikan desain dan menerima feedback.',
                                            ],
                                            'requirements': [
                                              'Mahasiswa aktif atau lulusan baru bidang Desain/Informatika.',
                                              'Paham dasar desain UI/UX.',
                                              'Mahir pakai Adobe XD, Figma, atau Sketch.',
                                              'Mampu bekerja individu/tim.',
                                              'Pengetahuan HTML/CSS nilai tambah.',
                                              'Terbuka dengan feedback dan revisi.',
                                            ],
                                          },
                                        ),
                                  ),
                                );
                              },
                              child: JobCard(
                                title: 'UI/UX Designer',
                                company: 'PT. Jaya Makmur',
                                location: 'Semarang',
                                workplace:
                                    index % 2 == 0 ? 'On site' : 'Remote',
                                salaryType: index % 2 == 0 ? 'Paid' : 'Unpaid',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
