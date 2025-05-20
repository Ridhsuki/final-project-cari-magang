import 'package:cari_magang_fe/app/core/components/jobcard.dart';
import 'package:cari_magang_fe/app/core/stringconst/assets_const.dart';
import 'package:cari_magang_fe/app/cubit/profile_cubit/profile_cubit.dart';
import 'package:cari_magang_fe/app/cubit/profile_cubit/profile_state.dart';
import 'package:cari_magang_fe/app/presentation/main/insiders/jobdetail_screen.dart';
import 'package:cari_magang_fe/data/models/internships_model/datum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cari_magang_fe/app/cubit/internships_cubit/internships_cubit.dart';
import 'package:cari_magang_fe/app/cubit/internships_cubit/internships_state.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  final String? locationFilter;
  final String? statusFilter;
  final String? systemFilter;

  const HomeScreen({
    super.key,
    this.locationFilter,
    this.statusFilter,
    this.systemFilter,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String? selectedLocation;
  late String? selectedStatus;
  late String? selectedSystem;

  @override
  void initState() {
    super.initState();
    context.read<InternshipsCubit>().getInternships();

    selectedLocation = widget.locationFilter;
    selectedStatus = widget.statusFilter;
    selectedSystem = widget.systemFilter;
  }

  void openFilterModel() async {
    final result = await showModalBottomSheet<Map<String, String?>>(
      context: context,
      builder: (context) {
        String? thisLocation = selectedLocation;
        String? thisStatus = selectedStatus;
        String? thisSystem = selectedSystem;

        return StatefulBuilder(
          builder:
              (context, setModalState) => Container(
                padding: const EdgeInsets.all(16),
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Place filter dropdown
                    DropdownButton<String>(
                      value: thisLocation,
                      hint: const Text('Select Location'),
                      isExpanded: true,
                      items:
                          <String>[
                                'Bekasi',
                                'Bandung',
                                'Tangerang',
                                'Solo',
                                'Malang',
                                'Jonggol',
                                'Semua',
                              ]
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e == 'Semua' ? null : e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                      onChanged: (val) {
                        setModalState(() => thisLocation = val);
                      },
                    ),

                    // Salary filter dropdown
                    DropdownButton<String>(
                      value: thisStatus,
                      hint: const Text('Select Status'),
                      isExpanded: true,
                      items:
                          <String>['paid', 'unpaid', 'Semua']
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e == 'Semua' ? null : e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                      onChanged: (val) {
                        setModalState(() => thisStatus = val);
                      },
                    ),

                    // System filter dropdown
                    DropdownButton<String>(
                      value: thisSystem,
                      hint: const Text('Select System'),
                      isExpanded: true,
                      items:
                          <String>['on-site', 'remote', 'hybrid', 'Semua']
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e == 'Semua' ? null : e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                      onChanged: (val) {
                        setModalState(() => thisSystem = val);
                      },
                    ),

                    const Spacer(),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, {
                          'location': thisLocation,
                          'status': thisStatus,
                          'system': thisSystem,
                        });
                      },
                      child: const Text('Apply Filter'),
                    ),
                  ],
                ),
              ),
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedLocation = result['location'];
        selectedStatus = result['status'];
        selectedSystem = result['system'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final internships = context.watch<InternshipsCubit>().state.internshipsData;
    final isLoading = context.watch<InternshipsCubit>().state.isLoading;

    final locationData = countJobsByLocation(internships);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return Text(
                      state.profile.data?.name ?? 'user',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(AssetsConst.searchIcon),
                        hintText: 'Search...',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 3,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: openFilterModel,
                    child: Column(
                      children: [
                        Image.asset(AssetsConst.filterIcon),
                        const Text('Filter', style: TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Chart
                      Center(
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.5),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child:
                              isLoading
                                  ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.deepOrange,
                                    ),
                                  )
                                  : LayoutBuilder(
                                    builder: (context, constraints) {
                                      return SizedBox(
                                        width: constraints.maxWidth,
                                        height: constraints.maxHeight,
                                        child: buildLocationChart(locationData),
                                      );
                                    },
                                  ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        'Terbaru',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Urbanist',
                        ),
                      ),
                      const SizedBox(height: 12),

                      BlocBuilder<InternshipsCubit, InternshipsState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.deepOrange,
                              ),
                            );
                          }
                          if (state.error.isNotEmpty) {
                            return Center(child: Text('Error: ${state.error}'));
                          }

                          final filteredInternships =
                              state.internshipsData.where((item) {
                                final matchesLocation =
                                    selectedLocation == null ||
                                    (item.location?.toLowerCase().contains(
                                          selectedLocation!.toLowerCase(),
                                        ) ??
                                        false);
                                final matchesStatus =
                                    selectedStatus == null ||
                                    (selectedStatus == 'paid' &&
                                        item.status == 'paid') ||
                                    (selectedStatus == 'unpaid' &&
                                        item.status == 'unpaid');
                                final matchesSystem =
                                    selectedSystem == null ||
                                    (selectedSystem == 'on-site' &&
                                        item.system == 'on-site') ||
                                    (selectedSystem == 'remote' &&
                                        item.system == 'remote') ||
                                    (selectedSystem == 'hybrid' &&
                                        item.system == 'hybrid');

                                return matchesLocation &&
                                    matchesStatus &&
                                    matchesSystem;
                              }).toList();

                          if (filteredInternships.isEmpty) {
                            return const Center(
                              child: Text('No internships found.'),
                            );
                          }

                          return ListView.builder(
                            itemCount: filteredInternships.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final item = filteredInternships[index];
                              return JobCard(
                                title: item.title ?? 'No Title',
                                company: item.user?.name ?? 'Perusahaan',
                                location: item.location ?? '-',
                                workplace: item.system ?? '-',
                                salaryType: item.status!,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => JobDetailScreen(
                                            internships: item,
                                          ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, int> countJobsByLocation(List<Datum> data) {
  final Map<String, int> locationCounts = {};

  for (var item in data) {
    final location = item.location ?? 'Unknown';
    locationCounts[location] = (locationCounts[location] ?? 0) + 1;
  }

  return locationCounts;
}

Widget buildLocationChart(Map<String, int> dataMap) {
  final List<BarChartGroupData> barGroups = [];
  int index = 0;

  dataMap.forEach((location, count) {
    barGroups.add(
      BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: count.toDouble(),
            color: Colors.deepOrange,
            width: 18,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
        showingTooltipIndicators: [],
      ),
    );
    index++;
  });

  return BarChart(
    BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: (dataMap.values.reduce((a, b) => a > b ? a : b)).toDouble() + 1,
      barGroups: barGroups,
      titlesData: FlTitlesData(
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              final location = dataMap.keys.toList()[value.toInt()];
              return Text(location, style: TextStyle(fontSize: 10));
            },
          ),
        ),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
    ),
  );
}
