import 'package:equatable/equatable.dart';

import '../../domain/entity/retreat_entity.dart';

abstract class RetreatEvent extends Equatable {
  const RetreatEvent();

  @override
  List<Object?> get props => [];
}

class LoadRetreats extends RetreatEvent {}

class AddRetreat extends RetreatEvent {
  final RetreatEntity retreatEntity;

  const AddRetreat(this.retreatEntity);

  @override
  List<Object?> get props => [retreatEntity];
}

class UpdateRetreat extends RetreatEvent {
  final String retreatId;
  final RetreatEntity retreatEntity;

  const UpdateRetreat(this.retreatId, this.retreatEntity);

  @override
  List<Object?> get props => [retreatId, retreatEntity];
}

class DeleteRetreat extends RetreatEvent {
  final String retreatId;

  const DeleteRetreat(this.retreatId);

  @override
  List<Object?> get props => [retreatId];
}
