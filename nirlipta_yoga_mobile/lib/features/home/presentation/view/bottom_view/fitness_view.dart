import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proximity_screen_lock/proximity_screen_lock.dart';
import 'package:sensors_plus/sensors_plus.dart';

class FitnessView extends StatefulWidget {
  const FitnessView({Key? key}) : super(key: key);

  @override
  State<FitnessView> createState() => _FitnessViewState();
}

class _FitnessViewState extends State<FitnessView> {
  bool isActive = false;
  bool isSupported = false;
  double stepCount = 8513;
  double distanceKm = 12.7;
  int durationMinutes = 152;
  double caloriesBurned = 6913;
  AccelerometerEvent? _accelerometerEvent;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    _checkProximitySupport();
    _listenToAccelerometer();
  }

  /// ✅ Check if Proximity Lock is Supported
  Future<void> _checkProximitySupport() async {
    try {
      bool supported = await ProximityScreenLock.isProximityLockSupported();
      setState(() {
        isSupported = supported;
      });
    } catch (e) {
      setState(() {
        isSupported = false;
      });
    }
  }

  /// ✅ Listen to Accelerometer Sensor Data
  void _listenToAccelerometer() {
    _streamSubscriptions.add(
      accelerometerEventStream().listen(
        (AccelerometerEvent event) {
          print(
              "Accelerometer Data: X:${event.x}, Y:${event.y}, Z:${event.z}"); // DEBUG LOG

          if (mounted) {
            setState(() {
              _accelerometerEvent = event;
            });
          }
        },
        onError: (e) {
          print("Accelerometer Error: $e"); // DEBUG ERROR
          if (mounted) {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor Not Found"),
                  content: Text(
                    "It seems that your device doesn't support the Accelerometer Sensor",
                  ),
                );
              },
            );
          }
        },
        cancelOnError: true,
      ),
    );
  }

  /// ✅ Activate Proximity Lock & Auto Unlock after 5s
  void _activateAndAutoUnlock() {
    setState(() {
      isActive = true;
    });

    ProximityScreenLock.setActive(true);
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          isActive = false;
        });
        ProximityScreenLock.setActive(false);
      }
    });
  }

  @override
  void dispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fitness Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ✅ Circular Step Count Display
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: stepCount / 10000,
                      strokeWidth: 10,
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.orange),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '$stepCount',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const Text(
                        'STEPS',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Metrics Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetric(
                    'KM', distanceKm.toString(), Icons.directions_walk),
                _buildMetric(
                    'MINUTES', durationMinutes.toString(), Icons.timer),
                _buildMetric('CALORIES', caloriesBurned.toString(),
                    Icons.local_fire_department),
              ],
            ),
            const SizedBox(height: 20),

            // ✅ Proximity Lock Button
            ElevatedButton(
              onPressed: _activateAndAutoUnlock,
              child: const Text('Activate Lock & Auto Unlock in 5s'),
            ),
            const SizedBox(height: 20),

            Text(
              isActive
                  ? 'Proximity Lock is Active'
                  : 'Proximity Lock is Inactive',
              style: Theme.of(context).textTheme.bodyLarge,
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
                    'X: ${_accelerometerEvent?.x.toStringAsFixed(2) ?? "0.00"}, '
                    'Y: ${_accelerometerEvent?.y.toStringAsFixed(2) ?? "0.00"}, '
                    'Z: ${_accelerometerEvent?.z.toStringAsFixed(2) ?? "0.00"}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
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
