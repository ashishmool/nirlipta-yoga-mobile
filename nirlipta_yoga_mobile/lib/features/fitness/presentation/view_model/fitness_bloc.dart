import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:pedometer/pedometer.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:sensors_plus/sensors_plus.dart';

part 'fitness_event.dart';
part 'fitness_state.dart';

class FitnessBloc extends Bloc<FitnessEvent, FitnessState> {
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  late StreamSubscription<StepCount> _stepCountSubscription;
  late StreamSubscription<int> _proximitySubscription;
  late StreamSubscription<Position> _positionSubscription;

  double stepCount = 0;
  double distanceKm = 0.0;
  int durationMinutes = 0;
  double caloriesBurned = 0.0;
  int proximityValue = 0;

  FitnessBloc() : super(FitnessInitial()) {
    on<StartTracking>(_startTracking);
    on<UpdateAccelerometer>(_updateAccelerometer);
    on<UpdateProximity>(_updateProximity);
    on<UpdatePosition>(_updatePosition); // ✅ Now properly registered
    on<UpdateStepCount>(_updateStepCount); // ✅ Add this line
  }

  void _updateStepCount(UpdateStepCount event, Emitter<FitnessState> emit) {
    print('Step Count Updated: ${event.stepCount.steps}');

    stepCount = event.stepCount.steps.toDouble();

    emit(FitnessUpdated(
      stepCount: stepCount,
      distanceKm: distanceKm,
      durationMinutes: durationMinutes,
      caloriesBurned: caloriesBurned,
      accelerometerEvent: state is FitnessUpdated
          ? (state as FitnessUpdated).accelerometerEvent
          : null,
      proximityValue: proximityValue,
      position:
          state is FitnessUpdated ? (state as FitnessUpdated).position : null,
    ));
  }

  void _startTracking(StartTracking event, Emitter<FitnessState> emit) async {
    // Request Location Permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      emit(FitnessUpdated(
        stepCount: stepCount,
        distanceKm: distanceKm,
        durationMinutes: durationMinutes,
        caloriesBurned: caloriesBurned,
        position: null,
        proximityValue: proximityValue,
      ));
      return;
    }
    // ✅ Listen for step count updates
    _stepCountSubscription =
        Pedometer.stepCountStream.listen((StepCount event) {
      add(UpdateStepCount(event));
    });

    // Start Listening to Live Location
    _positionSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      add(UpdatePosition(position));
    });

    _accelerometerSubscription =
        accelerometerEventStream().listen((AccelerometerEvent event) {
      add(UpdateAccelerometer(event));
    });

    _proximitySubscription = ProximitySensor.events.listen((int event) {
      proximityValue = event;
      add(UpdateProximity(proximityValue));
    });

    emit(FitnessUpdated(
      stepCount: stepCount,
      distanceKm: distanceKm,
      durationMinutes: durationMinutes,
      caloriesBurned: caloriesBurned,
      position: null,
      proximityValue: proximityValue,
    ));
  }

  void _updateAccelerometer(
      UpdateAccelerometer event, Emitter<FitnessState> emit) {
    emit(FitnessUpdated(
      stepCount: stepCount,
      distanceKm: distanceKm,
      durationMinutes: durationMinutes,
      caloriesBurned: caloriesBurned,
      accelerometerEvent: event.event,
      proximityValue: proximityValue,
      position:
          state is FitnessUpdated ? (state as FitnessUpdated).position : null,
    ));
  }

  void _updateProximity(UpdateProximity event, Emitter<FitnessState> emit) {
    emit(FitnessUpdated(
      stepCount: stepCount,
      distanceKm: distanceKm,
      durationMinutes: durationMinutes,
      caloriesBurned: caloriesBurned,
      accelerometerEvent: state is FitnessUpdated
          ? (state as FitnessUpdated).accelerometerEvent
          : null,
      proximityValue: event.proximityValue,
      position:
          state is FitnessUpdated ? (state as FitnessUpdated).position : null,
    ));
  }

  void _updatePosition(UpdatePosition event, Emitter<FitnessState> emit) {
    emit(FitnessUpdated(
      stepCount: stepCount,
      distanceKm: distanceKm,
      durationMinutes: durationMinutes,
      caloriesBurned: caloriesBurned,
      position: event.position,
      // ✅ Now correctly updating live position
      accelerometerEvent: state is FitnessUpdated
          ? (state as FitnessUpdated).accelerometerEvent
          : null,
      proximityValue: proximityValue,
    ));
  }

  @override
  Future<void> close() {
    _accelerometerSubscription.cancel();
    _stepCountSubscription.cancel();
    _proximitySubscription.cancel();
    _positionSubscription.cancel();
    return super.close();
  }
}
