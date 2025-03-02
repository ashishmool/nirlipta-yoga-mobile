import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_cubit.dart';

class Schedule {
  final String id;
  final String title;
  final String startTime;
  final String endTime;
  final String status;
  final List<String> daysOfWeek;

  Schedule({
    required this.id,
    required this.title,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.daysOfWeek,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['_id'],
      title: json['workshop_id']['title'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      status: json['status'],
      daysOfWeek: List<String>.from(json['days_of_week']),
    );
  }
}

class ViewScheduleUser extends StatefulWidget {
  final String userId;

  const ViewScheduleUser({Key? key, required this.userId}) : super(key: key);

  @override
  _ViewScheduleUserState createState() => _ViewScheduleUserState();
}

class _ViewScheduleUserState extends State<ViewScheduleUser> {
  List<Schedule> schedules = [];
  bool isLoading = true;

  final List<String> dayOrder = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  @override
  void initState() {
    super.initState();
    fetchSchedules();
  }

  Future<void> fetchSchedules() async {
    try {
      final response = await Dio().get(
        '${ApiEndpoints.baseUrl}schedules/user/${widget.userId}',
      );

      List<dynamic> data = response.data;
      setState(() {
        schedules = data.map((json) => Schedule.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching schedules: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Groups schedules by day and sorts them in correct order
  Map<String, List<Schedule>> groupByDay(List<Schedule> schedules) {
    Map<String, List<Schedule>> grouped = {};
    for (var schedule in schedules) {
      for (var day in schedule.daysOfWeek) {
        grouped.putIfAbsent(day, () => []).add(schedule);
      }
    }

    // Sort keys based on predefined order
    Map<String, List<Schedule>> sortedGrouped = {};
    for (var day in dayOrder) {
      if (grouped.containsKey(day)) {
        sortedGrouped[day] = grouped[day]!;
      }
    }
    return sortedGrouped;
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final isDarkMode = themeCubit.state.isDarkMode;
    final groupedSchedules = groupByDay(schedules);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Weekly Schedule'),
        backgroundColor: isDarkMode ? Colors.black : primaryColor,
        iconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : schedules.isEmpty
              ? const Center(
                  child: Text(
                    "No schedules available.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: groupedSchedules.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key, // Day of the week
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...entry.value.map((schedule) {
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _getStatusColor(schedule.status),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        schedule.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time,
                                              color: Colors.white70, size: 18),
                                          const SizedBox(width: 6),
                                          Text(
                                            "${schedule.startTime} - ${schedule.endTime}",
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "Status: ${schedule.status}",
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  _getStatusIcon(schedule.status),
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 16),
                      ],
                    );
                  }).toList(),
                ),
    );
  }

  /// Returns solid color based on status
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'canceled':
        return Colors.red;
      case 'paused':
        return Colors.orange;
      case 'active':
      default:
        return Colors.green;
    }
  }

  /// Returns appropriate icon based on status
  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'canceled':
        return Icons.cancel;
      case 'paused':
        return Icons.pause;
      case 'active':
      default:
        return Icons.timelapse;
    }
  }
}
