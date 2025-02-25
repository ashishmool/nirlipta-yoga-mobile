import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/core/theme/app_theme.dart';
import 'package:proximity_screen_lock/proximity_screen_lock.dart';

import '../../../../core/theme/theme_cubit.dart';
import '../view_model/fitness_bloc.dart';

class FitnessView extends StatelessWidget {
  const FitnessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>(); // Watch theme state
    final isDarkMode = themeCubit.state.isDarkMode; // Check theme mode
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
                  // ✅ Step Count Progress Indicator
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
                                color: Colors.orange,
                              ),
                            ),
                            const Text(
                              'STEPS',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ✅ Metrics Row (Distance, Duration, Calories)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetric('KM', state.distanceKm.toStringAsFixed(2),
                          Icons.directions_walk),
                      _buildMetric('MINUTES', state.durationMinutes.toString(),
                          Icons.timer),
                      _buildMetric(
                          'CALORIES',
                          state.caloriesBurned.toStringAsFixed(1),
                          Icons.local_fire_department),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ✅ Live Location Display
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Live Location",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          state.position != null
                              ? 'Latitude: ${state.position!.latitude.toStringAsFixed(6)},\nLongitude: ${state.position!.longitude.toStringAsFixed(6)}'
                              : 'Fetching location...',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ✅ Proximity Lock Button
                  ElevatedButton(
                    onPressed: () {
                      ProximityScreenLock.setActive(true);
                      Future.delayed(const Duration(seconds: 5), () {
                        ProximityScreenLock.setActive(false);
                      });
                    },
                    child: const Text('Activate Lock & Auto Unlock in 5s'),
                  ),
                  const SizedBox(height: 20),

                  // ✅ Accelerometer Data Display
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Accelerometer Data",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          state.accelerometerEvent != null
                              ? 'X: ${state.accelerometerEvent!.x.toStringAsFixed(2)}, '
                                  'Y: ${state.accelerometerEvent!.y.toStringAsFixed(2)}, '
                                  'Z: ${state.accelerometerEvent!.z.toStringAsFixed(2)}'
                              : 'No Data',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// ✅ Builds a Metric Widget for Steps, Distance, etc.
  Widget _buildMetric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.deepOrange),
        const SizedBox(height: 5),
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
