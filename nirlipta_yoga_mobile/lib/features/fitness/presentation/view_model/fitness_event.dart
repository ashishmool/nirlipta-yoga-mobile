part of 'fitness_bloc.dart';

@immutable
sealed class FitnessEvent {}

class StartTracking extends FitnessEvent {}

class UpdateAccelerometer extends FitnessEvent {
  final AccelerometerEvent event;

  UpdateAccelerometer(this.event);
}

class UpdatePosition extends FitnessEvent {
  final Position position;

  UpdatePosition(this.position);
}
