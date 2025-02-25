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

class UpdateProximity extends FitnessEvent {
  final int proximityValue; // ✅ Keep it as int
  UpdateProximity(this.proximityValue);
}

class UpdateStepCount extends FitnessEvent {
  final StepCount stepCount;

  UpdateStepCount(this.stepCount);
}
