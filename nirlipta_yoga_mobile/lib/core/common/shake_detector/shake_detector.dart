import 'dart:async';
import 'dart:ui';

import 'package:sensors_plus/sensors_plus.dart';

class ShakeDetector {
  final VoidCallback onShake;
  final double shakeThresholdGravity;
  final int shakeSlopTimeMS;
  final int shakeCountResetTime;

  DateTime? _lastShakeTime;
  int _shakeCount = 0;
  StreamSubscription<UserAccelerometerEvent>? _subscription;

  ShakeDetector({
    required this.onShake,
    this.shakeThresholdGravity = 2.5,
    this.shakeSlopTimeMS = 500,
    this.shakeCountResetTime = 3000,
  });

  void startListening() {
    _subscription = userAccelerometerEventStream().listen(
      (UserAccelerometerEvent event) {
        final double x = event.x;
        final double y = event.y;
        final double z = event.z;

        final double gX = x / 9.81;
        final double gY = y / 9.81;
        final double gZ = z / 9.81;

        final double gForce = (gX * gX + gY * gY + gZ * gZ);

        if (gForce > shakeThresholdGravity) {
          final DateTime now = DateTime.now();

          if (_lastShakeTime != null &&
              now.difference(_lastShakeTime!).inMilliseconds <
                  shakeSlopTimeMS) {
            return;
          }

          if (_lastShakeTime != null &&
              now.difference(_lastShakeTime!).inMilliseconds >
                  shakeCountResetTime) {
            _shakeCount = 0;
          }

          _lastShakeTime = now;
          _shakeCount++;

          if (_shakeCount >= 2) {
            _shakeCount = 0;
            onShake();
          }
        }
      },
      onError: (error) {
        print('Error in shake detection: $error');
      },
      cancelOnError: true,
    );
  }

  void stopListening() {
    _subscription?.cancel();
  }
}
