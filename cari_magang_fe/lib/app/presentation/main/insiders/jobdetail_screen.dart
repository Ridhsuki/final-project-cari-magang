import 'package:cari_magang_fe/app/core/components/jobdetail.dart';
import 'package:cari_magang_fe/data/models/internships_model/datum.dart';
import 'package:flutter/material.dart';

class JobDetailScreen extends StatelessWidget {
  final Datum internships;

  const JobDetailScreen({
    super.key,
    required this.internships,
  });

  @override
  Widget build(BuildContext context) {
    return JobDetailWidget(
      internshipId: internships.id!,
      title: internships.title ?? 'No title',
      category: internships.category?.name ?? 'Tidak disebutkan',
      location: internships.location ?? 'Tidak disebutkan',
      system: internships.system ?? 'Tidak disebutkan',
      status: internships.status ?? 'Tidak disebutkan',
      name: internships.user?.name ?? 'Tanpa nama perusahaan',
      description: internships.description ?? 'Tidak ada deskripsi',
    );
  }
}
