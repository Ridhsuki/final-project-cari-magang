import 'package:cari_magang_fe/app/core/appcolors.dart';
import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String workplace;
  final String salaryType;
  final VoidCallback? onTap;

  const JobCard({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.workplace,
    required this.salaryType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Appcolors.primaryColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                company,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(location, style: TextStyle(fontSize: 13)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    // decoration: BoxDecoration(
                    //   color:
                    //       salaryType == 'Paid'
                    //           ? Colors.green[500]
                    //           : Colors.black,
                    //   borderRadius: BorderRadius.circular(8),
                    // ),
                    child: Text(
                      salaryType,
                      style: TextStyle(
                        color:
                            salaryType == 'paid'
                                ? Colors.green[500]
                                : Colors.yellow[700],
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
                  color: Appcolors.primaryColor,
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
