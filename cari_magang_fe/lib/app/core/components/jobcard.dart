import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String workplace;
  final String salaryType;

  const JobCard({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.workplace,
    required this.salaryType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Job Title
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 8),

          // Company and Location
          Text('$company\n$location', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 12),

          // Workplace and Salary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                workplace,
                style: const TextStyle(fontSize: 12, color: Colors.orange),
              ),
              Text(
                salaryType,
                style: const TextStyle(fontSize: 12, color: Colors.orange),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
