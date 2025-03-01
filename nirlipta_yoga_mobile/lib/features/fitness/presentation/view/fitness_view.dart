import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/core/theme/app_theme.dart';
import 'package:proximity_screen_lock/proximity_screen_lock.dart';

import '../../../../core/common/live_location.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../view_model/fitness_bloc.dart';

class FitnessView extends StatefulWidget {
  const FitnessView({Key? key}) : super(key: key);

  @override
  State<FitnessView> createState() => _FitnessViewState();
}

class _FitnessViewState extends State<FitnessView> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false; // ✅ Toggle state for button

  @override
  void initState() {
    super.initState();
    ProximityScreenLock.setActive(true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    ProximityScreenLock.setActive(false);
    super.dispose();
  }

  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final isDarkMode = themeCubit.state.isDarkMode;

    return BlocProvider(
      create: (context) => FitnessBloc()..add(StartTracking()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fitness Dashboard'),
          backgroundColor: isDarkMode ? Colors.grey[900] : primaryColor,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        body: BlocBuilder<FitnessBloc, FitnessState>(
          builder: (context, state) {
            if (state is! FitnessUpdated) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ✅ Live Location Display
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Live Location",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: state.position != null
                                ? LiveLocationScreen(
                                    latitude: state.position!.latitude,
                                    longitude: state.position!.longitude,
                                  )
                                : const Center(
                                    child: CircularProgressIndicator()),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ✅ Step Count Progress Indicator + Start Button
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            value: state.stepCount / 10000,
                            strokeWidth: 10,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.orange),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              state.stepCount.toStringAsFixed(0),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            const Text(
                              'STEPS',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            const SizedBox(height: 8),

                            // ✅ Start/Stop Button
                            ElevatedButton.icon(
                              onPressed: _toggleTimer,
                              icon: Icon(
                                _isRunning
                                    ? Icons.stop // Stop Icon
                                    : Icons.play_arrow, // Play Icon
                                color: Colors.white,
                              ),
                              label: Text(
                                _isRunning ? "Stop" : "Start",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                backgroundColor:
                                    _isRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ✅ Metrics Row (Distance, Duration, Calories)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetric('KM', state.distanceKm.toStringAsFixed(2),
                          Icons.directions_walk, secondaryColor),

                      // ✅ Timer display below the icon
                      Column(
                        children: [
                          // _buildMetric('TIMER', '', Icons.timer, primaryColor),
                          const Icon(Icons.timer,
                              size: 40, color: Colors.green),
                          Text(
                            "${_seconds % 60}s", // Show seconds
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      _buildMetric(
                          'CALORIES',
                          state.caloriesBurned.toStringAsFixed(1),
                          Icons.local_fire_department,
                          Colors.red),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// ✅ Builds a Metric Widget for Steps, Distance, etc.
  Widget _buildMetric(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 30, color: color),
        const SizedBox(height: 5),
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
