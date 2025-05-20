import 'package:cari_magang_fe/app/core/appcolors.dart';
import 'package:cari_magang_fe/app/core/components/appliedcard.dart';
import 'package:cari_magang_fe/app/cubit/appliedstatus_cubit/applied_status_cubit.dart';
import 'package:cari_magang_fe/app/cubit/appliedstatus_cubit/applied_status_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class JobappliedScreen extends StatefulWidget {
  const JobappliedScreen({super.key});

  @override
  State<JobappliedScreen> createState() => _JobappliedScreenState();
}

class _JobappliedScreenState extends State<JobappliedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AppliedStatusCubit>().getAppliedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Appcolors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Status Lamaran',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
            fontFamily: 'Urbanist',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<AppliedStatusCubit, AppliedStatusState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.deepOrange),
              );
            }

            if (state.error.isNotEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Error: ${state.error}',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (state.appliedInternship.isEmpty) {
              return const Center(
                child: Text('Belum ada lamaran yang di kirim.'),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: state.appliedInternship.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = state.appliedInternship[index];
                        return AppliedCard(
                          title: item.internship?.title ?? '',
                          company: item.internship?.company ?? '',
                          status: item.status ?? 'pending',
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
