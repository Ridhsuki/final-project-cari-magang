import 'package:cari_magang_fe/app/core/components/jobcard.dart';
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
          padding: const EdgeInsets.all(16),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              const Text(
                'ALDO FERNAN',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Search bar and filter
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.filter_list, color: Colors.orange),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Chart Placeholder
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(child: Text('Chart Placeholder')),
              ),
              const SizedBox(height: 16),

              // Tersedia title
              const Text(
                'Tersedia',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 12),

              // Expanded scrollable job list
              Expanded(
                child: ListView.builder(
                  itemCount: 10, // Misalnya ada 10 loker
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
                                          index % 2 == 0 ? 'On site' : 'Remote',
                                      'salaryType':
                                          index % 2 == 0 ? 'Paid' : 'Unpaid',
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
                          workplace: index % 2 == 0 ? 'On site' : 'Remote',
                          salaryType: index % 2 == 0 ? 'Paid' : 'Unpaid',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
