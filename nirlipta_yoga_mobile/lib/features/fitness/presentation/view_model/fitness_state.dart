part of 'fitness_bloc.dart';

@immutable
abstract class FitnessState {}

class FitnessInitial extends FitnessState {}

class FitnessUpdated extends FitnessState {
  final double stepCount;
  final double distanceKm;
  final int durationMinutes;
  final double caloriesBurned;
  final Position? position;
  final AccelerometerEvent? accelerometerEvent;
  final int proximityValue;

  FitnessUpdated({
    required this.stepCount,
    this.position,
    required this.distanceKm,
    required this.durationMinutes,
    required this.caloriesBurned,
    this.accelerometerEvent,
    required this.proximityValue,
  });
}
