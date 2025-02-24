import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:pedometer/pedometer.dart';
import 'package:sensors_plus/sensors_plus.dart';

part 'fitness_event.dart';
part 'fitness_state.dart';

class FitnessBloc extends Bloc<FitnessEvent, FitnessState> {
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  late StreamSubscription<StepCount> _stepCountSubscription;
  double stepCount = 0;
  double distanceKm = 0.0;
  int durationMinutes = 0;
  double caloriesBurned = 0.0;

  FitnessBloc() : super(FitnessInitial()) {
    on<StartTracking>(_startTracking);
    on<UpdateAccelerometer>((event, emit) {
      emit(FitnessUpdated(
        stepCount: stepCount,
        distanceKm: distanceKm,
        durationMinutes: durationMinutes,
        caloriesBurned: caloriesBurned,
        accelerometerEvent: event.event,
      ));
    });
  }

  void _startTracking(StartTracking event, Emitter<FitnessState> emit) {
    // Emit initial state to update UI
    emit(FitnessUpdated(
      stepCount: stepCount,
      distanceKm: distanceKm,
      durationMinutes: durationMinutes,
      caloriesBurned: caloriesBurned,
      accelerometerEvent: null,
    ));

    _stepCountSubscription =
        Pedometer.stepCountStream.listen((StepCount event) {
      stepCount = event.steps.toDouble();
      distanceKm = stepCount * 0.0008; // Assuming 0.8m per step
      durationMinutes = (stepCount / 100).toInt();
      caloriesBurned = stepCount * 0.04;

      emit(FitnessUpdated(
        stepCount: stepCount,
        distanceKm: distanceKm,
        durationMinutes: durationMinutes,
        caloriesBurned: caloriesBurned,
        accelerometerEvent: null,
      ));
    });

    _accelerometerSubscription =
        accelerometerEventStream().listen((AccelerometerEvent event) {
      add(UpdateAccelerometer(event));
    });
  }

  @override
  Future<void> close() {
    _stepCountSubscription.cancel();
    _accelerometerSubscription.cancel();
    return super.close();
  }
}
