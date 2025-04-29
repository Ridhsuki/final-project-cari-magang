import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget {
  final List<Map<String, String>> savedJobs = [
    {
      'title': 'UI UX Desainer',
      'company': 'PT. Efishery',
      'location': 'Semarang Timur',
      'type': 'Onsite | Paid Intern',
    },
    {
      'title': 'Graphic Design',
      'company': 'PT. Efishery',
      'location': 'Semarang Timur',
      'type': 'Onsite | Paid Intern',
    },
  ];

  SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Saved',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: savedJobs.length,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (context, index) {
          final job = savedJobs[index];
          return Container(
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
                  job['title']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(job['company']!, style: TextStyle(color: Colors.black87)),
                Text(job['location']!, style: TextStyle(color: Colors.black54)),
                const SizedBox(height: 6),
                Text(
                  job['type']!,
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
