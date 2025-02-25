import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_theme.dart';
import '../../core/theme/theme_cubit.dart';

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

  @override
  void initState() {
    super.initState();
    fetchSchedules();
  }

  Future<void> fetchSchedules() async {
    try {
      final response = await Dio().get(
        'http://10.0.2.2:5000/api/schedules/user/${widget.userId}',
      );

      List<dynamic> data = response.data;
      print(response.data);
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

  Map<String, List<Schedule>> groupByDay(List<Schedule> schedules) {
    Map<String, List<Schedule>> grouped = {};
    for (var schedule in schedules) {
      for (var day in schedule.daysOfWeek) {
        grouped.putIfAbsent(day, () => []).add(schedule);
      }
    }
    return grouped;
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'canceled':
        return Colors.red;
      case 'paused':
        return Colors.yellow;
      case 'active':
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>(); // Watch theme state
    final isDarkMode = themeCubit.state.isDarkMode; // Check theme mode
    final groupedSchedules = groupByDay(schedules);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Routines'),
        backgroundColor: isDarkMode ? Colors.grey[900] : primaryColor,
        actions: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       // Handle "Request Leave" action
          //     },
          //     style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
          //     child: const Text("Request Leave"),
          //   ),
          // ),
        ],
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
                  padding: const EdgeInsets.all(12),
                  children: groupedSchedules.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key, // Day of the week
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...entry.value.map((schedule) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: getStatusColor(schedule.status),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Title: ${schedule.title}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${schedule.startTime} - ${schedule.endTime}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 12),
                      ],
                    );
                  }).toList(),
                ),
    );
  }
}
