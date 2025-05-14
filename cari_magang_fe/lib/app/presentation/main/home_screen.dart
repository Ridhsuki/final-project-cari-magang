import 'package:cari_magang_fe/app/core/components/jobcard.dart';
import 'package:cari_magang_fe/app/core/components/jobdetail.dart';
import 'package:cari_magang_fe/app/core/stringconst/assets_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cari_magang_fe/app/cubit/internships_cubit/internships_cubit.dart';
import 'package:cari_magang_fe/app/cubit/internships_cubit/internships_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InternshipsCubit>().getInternships();
  }

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
              const Center(
                child: Text(
                  'ALDO FERNAN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(AssetsConst.searchIcon),
                        hintText: 'Search...',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 3,
                          ),
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
                      const Text('Filter', style: TextStyle(fontSize: 11)),
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
                                offset: const Offset(0, 3),
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

                      BlocBuilder<InternshipsCubit, InternshipsState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state.error != '') {
                            return Center(child: Text('Error: ${state.error}'));
                          }
                          if (state.internshipsData.isEmpty) {
                            return const Center(
                              child: Text('No internships available.'),
                            );
                          }

                          return ListView.builder(
                            itemCount: state.internshipsData.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final item = state.internshipsData[index];
                              return JobCard(
                                title: item.title ?? 'No Title',
                                company: item.user?.name ?? 'Perusahaan',
                                location: item.location ?? '-',
                                workplace: item.system ?? '-',
                                salaryType:
                                    item.status == 'Paid' ? 'Paid' : 'Unpaid',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => JobDetailWidget(
                                            title: item.title ?? '-',
                                            category:
                                                item.category?.name ?? '-',
                                            location: item.location ?? '-',
                                            system: item.system ?? '-',
                                            status: item.status ?? '-',
                                            name: item.user?.name ?? '-',
                                            description:
                                                item.description ?? '-',
                                          ),
                                    ),
                                  );
                                },
                              );
                            },
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
