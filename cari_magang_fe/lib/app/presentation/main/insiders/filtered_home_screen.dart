import 'package:cari_magang_fe/app/core/stringconst/assets_const.dart';
import 'package:flutter/material.dart';
import 'package:cari_magang_fe/app/presentation/main/home_screen.dart';

class FilteredHomeScreen extends StatefulWidget {
  const FilteredHomeScreen({super.key});

  @override
  State<FilteredHomeScreen> createState() => _FilteredHomeScreenState();
}

class _FilteredHomeScreenState extends State<FilteredHomeScreen> {
  bool isFilterVisible = false;

  String? selectedLocation;
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HomeScreen(
          locationFilter: selectedLocation,
          statusFilter: selectedStatus,
        ),

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
                      "Location",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children:
                          ['Bekasi', 'Bandung', 'Tangerang'].map((location) {
                            return FilterChip(
                              label: Text(location),
                              selected: selectedLocation == location,
                              onSelected: (val) {
                                setState(() {
                                  selectedLocation = val ? location : null;
                                });
                              },
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Status",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children:
                          ['paid', 'unpaid'].map((status) {
                            return FilterChip(
                              label: Text(status),
                              selected: selectedStatus == status,
                              onSelected: (val) {
                                setState(() {
                                  selectedStatus = val ? status : null;
                                });
                              },
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedLocation = null;
                              selectedStatus = null;
                              isFilterVisible = false;
                            });
                          },
                          child: const Text('Reset'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isFilterVisible = false;
                            });
                          },
                          child: const Text('Apply'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Filter button
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
                Image.asset(AssetsConst.filterIcon, height: 24),
                const Text('Filter', style: TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
