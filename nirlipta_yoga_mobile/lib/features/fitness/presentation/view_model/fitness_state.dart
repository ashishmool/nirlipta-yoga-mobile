part of 'fitness_bloc.dart';

@immutable
sealed class FitnessState {}

final class FitnessInitial extends FitnessState {}

final class FitnessUpdated extends FitnessState {
  final double stepCount;
  final double distanceKm;
  final int durationMinutes;
  final double caloriesBurned;
  final AccelerometerEvent? accelerometerEvent;
  final Position? position; // Add position field

  FitnessUpdated({
    required this.stepCount,
    required this.distanceKm,
    required this.durationMinutes,
    required this.caloriesBurned,
    this.accelerometerEvent,
    this.position, // Include position
  });
}
