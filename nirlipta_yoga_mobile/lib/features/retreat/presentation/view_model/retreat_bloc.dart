import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/retreat_use_case.dart';
import 'retreat_event.dart';
import 'retreat_state.dart';

class RetreatBloc extends Bloc<RetreatEvent, RetreatState> {
  final GetRetreatsUseCase getRetreatsUseCase;
  final AddRetreatUseCase addRetreatUseCase;
  final UpdateRetreatUseCase updateRetreatUseCase;
  final DeleteRetreatUseCase deleteRetreatUseCase;

  RetreatBloc({
    required this.getRetreatsUseCase,
    required this.addRetreatUseCase,
    required this.updateRetreatUseCase,
    required this.deleteRetreatUseCase,
  }) : super(RetreatLoading()) {
    on<LoadRetreats>(_onLoadRetreats);
    on<AddRetreat>(_onAddRetreat);
    on<UpdateRetreat>(_onUpdateRetreat);
    on<DeleteRetreat>(_onDeleteRetreat);
  }

  Future<void> _onLoadRetreats(
    LoadRetreats event,
    Emitter<RetreatState> emit,
  ) async {
    try {
      emit(RetreatLoading());
      final result = await getRetreatsUseCase();
      result.fold(
        (failure) =>
            emit(RetreatError('Failed to load retreats: ${failure.message}')),
        (retreats) => emit(RetreatLoaded(retreats)),
      );
    } catch (e) {
      emit(RetreatError('An unexpected error occurred: $e'));
    }
  }

  Future<void> _onAddRetreat(
    AddRetreat event,
    Emitter<RetreatState> emit,
  ) async {
    try {
      emit(RetreatLoading());
      final result = await addRetreatUseCase(event.retreatEntity);
      result.fold(
        (failure) =>
            emit(RetreatError('Failed to add retreat: ${failure.message}')),
        (_) => add(LoadRetreats()), // Reload retreats after adding
      );
    } catch (e) {
      emit(RetreatError('An unexpected error occurred: $e'));
    }
  }

  Future<void> _onUpdateRetreat(
    UpdateRetreat event,
    Emitter<RetreatState> emit,
  ) async {
    try {
      emit(RetreatLoading());
      final result =
          await updateRetreatUseCase(event.retreatId, event.retreatEntity);
      result.fold(
        (failure) =>
            emit(RetreatError('Failed to update retreat: ${failure.message}')),
        (_) => add(LoadRetreats()), // Reload retreats after updating
      );
    } catch (e) {
      emit(RetreatError('An unexpected error occurred: $e'));
    }
  }

  Future<void> _onDeleteRetreat(
    DeleteRetreat event,
    Emitter<RetreatState> emit,
  ) async {
    try {
      emit(RetreatLoading());
      final result = await deleteRetreatUseCase(event.retreatId);
      result.fold(
        (failure) =>
            emit(RetreatError('Failed to delete retreat: ${failure.message}')),
        (_) => add(LoadRetreats()), // Reload retreats after deleting
      );
    } catch (e) {
      emit(RetreatError('An unexpected error occurred: $e'));
    }
  }
}
