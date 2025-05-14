import 'package:flutter/material.dart';
import 'package:cari_magang_fe/app/presentation/main/home_screen.dart';

class FilteredHomeScreen extends StatefulWidget {
  const FilteredHomeScreen({super.key});

  @override
  State<FilteredHomeScreen> createState() => _FilteredHomeScreenState();
}

class _FilteredHomeScreenState extends State<FilteredHomeScreen> {
  bool isFilterVisible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const HomeScreen(),

        // Filter Overlay
        if (isFilterVisible)
          Positioned(
            top: 110,
            right: 24,
            left: 24,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Place",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children:
                          ['onsite', 'online', 'hybrid'].map((place) {
                            return FilterChip(
                              label: Text(place),
                              selected: false,
                              onSelected: (val) {},
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Salary",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children:
                          ['paid', 'unpaid'].map((salary) {
                            return FilterChip(
                              label: Text(salary),
                              selected: false,
                              onSelected: (val) {},
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Filter button (overlayed)
        Positioned(
          top: 72,
          right: 34,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isFilterVisible = !isFilterVisible;
              });
            },
            child: Column(
              children: [
                Image.asset('assets/images/funnel.png', height: 24),
                const Text('Filter', style: TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
