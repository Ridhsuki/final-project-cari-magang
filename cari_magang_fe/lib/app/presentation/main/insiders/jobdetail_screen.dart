import 'package:cari_magang_fe/app/core/components/jobdetail.dart';
import 'package:flutter/material.dart';

class JobDetailScreen extends StatelessWidget {
  final Map<String, dynamic> job;

  const JobDetailScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JobDetailWidget(
        title: job['title'],
        salary: job['salary'],
        qualification: job['qualification'],
        location: job['location'],
        workplace: job['workplace'],
        submission: job['submission'],
        company: job['company'],
        recruiter: job['recruiter'],
        description: job['description'],
        duties: job['duties'],
        requirements: job['requirements'],
      ),
    );
  }
}
