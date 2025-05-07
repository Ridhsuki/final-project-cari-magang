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
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(company, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(location),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          salaryType == 'Paid'
                              ? Colors.green[100]
                              : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      salaryType,
                      style: TextStyle(
                        color:
                            salaryType == 'Paid'
                                ? Colors.green[800]
                                : Colors.grey[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                workplace,
                style: TextStyle(
                  color: Colors.blueGrey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
