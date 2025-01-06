import 'package:equatable/equatable.dart';

import '../../domain/entity/retreat_entity.dart';

abstract class RetreatState extends Equatable {
  const RetreatState();

  @override
  List<Object?> get props => [];
}

class RetreatLoading extends RetreatState {}

class RetreatLoaded extends RetreatState {
  final List<RetreatEntity> retreats;

  const RetreatLoaded(this.retreats);

  @override
  List<Object?> get props => [retreats];
}

class RetreatError extends RetreatState {
  final String message;

  const RetreatError(this.message);

  @override
  List<Object?> get props => [message];
}
