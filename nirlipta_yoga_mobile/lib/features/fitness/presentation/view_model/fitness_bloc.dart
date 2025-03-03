import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:sensors_plus/sensors_plus.dart';

part 'fitness_event.dart';
part 'fitness_state.dart';

class FitnessBloc extends Bloc<FitnessEvent, FitnessState> {
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  late StreamSubscription<int> _proximitySubscription;
  late StreamSubscription<Position> _positionSubscription;

  double stepCount = 0;
  double distanceKm = 0.0;
  int durationMinutes = 0;
  double caloriesBurned = 0.0;
  int proximityValue = 0;

  // Variables for step detection
  double _previousAcceleration = 0.0;
  double _accelerationThreshold = 1.5; // Adjust this threshold as needed
  bool _isTracking = false;

  FitnessBloc() : super(FitnessInitial()) {
    on<StartTracking>(_startTracking);
    on<UpdateAccelerometer>(_updateAccelerometer);
    on<UpdateProximity>(_updateProximity);
    on<UpdatePosition>(_updatePosition);
    on<UpdateStepCount>(_updateStepCount);
    on<PauseTracking>(_pauseTracking);
    on<ResetTracking>(_resetTracking);
  }

  void _updateStepCount(UpdateStepCount event, Emitter<FitnessState> emit) {
    stepCount = event.stepCount.toDouble();

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

    // Start Listening to Live Location
    _positionSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      add(UpdatePosition(position));
    });

    // Start Listening to Accelerometer for Step Detection
    _accelerometerSubscription =
        accelerometerEventStream().listen((AccelerometerEvent event) {
      if (_isTracking) {
        _detectSteps(event);
      }
    });

    _proximitySubscription = ProximitySensor.events.listen((int event) {
      proximityValue = event;
      add(UpdateProximity(proximityValue));
    });

    _isTracking = true;

    emit(FitnessUpdated(
      stepCount: stepCount,
      distanceKm: distanceKm,
      durationMinutes: durationMinutes,
      caloriesBurned: caloriesBurned,
      position: null,
      proximityValue: proximityValue,
    ));
  }

  void _pauseTracking(PauseTracking event, Emitter<FitnessState> emit) {
    _isTracking = false;
    emit(FitnessUpdated(
      stepCount: stepCount,
      distanceKm: distanceKm,
      durationMinutes: durationMinutes,
      caloriesBurned: caloriesBurned,
      position:
          state is FitnessUpdated ? (state as FitnessUpdated).position : null,
      proximityValue: proximityValue,
    ));
  }

  void _resetTracking(ResetTracking event, Emitter<FitnessState> emit) {
    stepCount = 0;
    durationMinutes = 0;
    _isTracking = false;
    emit(FitnessUpdated(
      stepCount: stepCount,
      distanceKm: distanceKm,
      durationMinutes: durationMinutes,
      caloriesBurned: caloriesBurned,
      position:
          state is FitnessUpdated ? (state as FitnessUpdated).position : null,
      proximityValue: proximityValue,
    ));
  }

  void _detectSteps(AccelerometerEvent event) {
    // Calculate the magnitude of acceleration
    double acceleration = _calculateAcceleration(event);

    // Detect steps based on acceleration changes
    if (acceleration > _accelerationThreshold &&
        _previousAcceleration <= _accelerationThreshold) {
      stepCount++;
      add(UpdateStepCount(stepCount.toInt()));
    }

    _previousAcceleration = acceleration;
  }

  double _calculateAcceleration(AccelerometerEvent event) {
    // Calculate the magnitude of acceleration
    return (event.x * event.x + event.y * event.y + event.z * event.z).abs();
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
      accelerometerEvent: state is FitnessUpdated
          ? (state as FitnessUpdated).accelerometerEvent
          : null,
      proximityValue: proximityValue,
    ));
  }

  @override
  Future<void> close() {
    _accelerometerSubscription.cancel();
    _proximitySubscription.cancel();
    _positionSubscription.cancel();
    return super.close();
  }
}
