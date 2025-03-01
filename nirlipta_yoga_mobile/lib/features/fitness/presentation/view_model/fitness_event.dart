part of 'fitness_bloc.dart';

@immutable
sealed class FitnessEvent {}

class StartTracking extends FitnessEvent {}

class PauseTracking extends FitnessEvent {}

class ResetTracking extends FitnessEvent {}

class UpdateAccelerometer extends FitnessEvent {
  final AccelerometerEvent event;

  UpdateAccelerometer(this.event);
}

class UpdatePosition extends FitnessEvent {
  final Position position;

  UpdatePosition(this.position);
}

class UpdateProximity extends FitnessEvent {
  final int proximityValue;

  UpdateProximity(this.proximityValue);
}

class UpdateStepCount extends FitnessEvent {
  final int stepCount;

  UpdateStepCount(this.stepCount);
}
