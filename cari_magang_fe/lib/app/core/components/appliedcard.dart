import 'package:cari_magang_fe/app/core/appcolors.dart';
import 'package:flutter/material.dart';

class AppliedCard extends StatelessWidget {
  final String title;
  final String company;
  final String status;
  final VoidCallback? onTap;

  AppliedCard({
    super.key,
    required this.title,
    required this.company,
    required this.status,
    this.onTap,
  });

  // List of stages for the application process
  final List<String> stages = [
    'Applied',
    'Pengecekan file',
    'Interview',
    'Final Decision',
  ];

  // Function to build the progress bar with active color
  Widget _buildProgressBar(BuildContext context) {
    bool isAfterDecision = status == 'approved' || status == 'rejected';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          stages.map((stage) {
            Color stageColor = Colors.grey;

            // Logic to make all stages active after approval or rejection
            if (isAfterDecision || stage == 'Applied') {
              stageColor =
                  Appcolors
                      .primaryColor; // Use primary color for all stages after decision
            }

            // If the stage is exactly the current status, highlight it
            if (stage == status) {
              stageColor =
                  Appcolors
                      .primaryColor; // Make it more prominent for the active stage
            }

            return Expanded(
              child: Column(
                children: [
                  Icon(Icons.circle, color: stageColor, size: 12),
                  const SizedBox(height: 4),
                  Text(
                    stage,
                    style: TextStyle(
                      color: stageColor,
                      fontSize: 9,
                      fontWeight:
                          (stage == status)
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  // Function to create a simple badge for status
  Widget _buildStatusBadge(String status) {
    Color badgeColor;
    String label;

    // Determine badge color and label based on the status
    switch (status.toLowerCase()) {
      case 'approved':
        badgeColor = Colors.green[500]!;
        label = 'Approved';
        break;
      case 'rejected':
        badgeColor = Colors.red[500]!;
        label = 'Rejected';
        break;
      case 'pending':
        badgeColor = Colors.orange[700]!;
        label = 'Pending';
        break;
      default:
        badgeColor = Colors.grey;
        label = 'Unknown';
    }

    // Simple badge design with a flat background and rounded corners
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white, // White text for better contrast
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Appcolors.primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  // Display the simple status badge next to the title
                  _buildStatusBadge(status),
                ],
              ),
              SizedBox(height: 6),
              Text(
                company,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              SizedBox(height: 12),
              // Display the entire progress status here
              _buildProgressBar(context),
            ],
          ),
        ),
      ),
    );
  }
}
