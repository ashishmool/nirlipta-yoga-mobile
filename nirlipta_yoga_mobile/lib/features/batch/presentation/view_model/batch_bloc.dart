import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/batch_entity.dart';
import '../../domain/use_case/create_batch_usecase.dart';
import '../../domain/use_case/delete_batch_usecase.dart';
import '../../domain/use_case/get_all_batch_usecase.dart';

part 'batch_event.dart';
part 'batch_state.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  final CreateBatchUseCase _createBatchUseCase;
  final GetAllBatchUseCase _getAllBatchUseCase;
  final DeleteBatchUseCase _deleteBatchUseCase;

  BatchBloc({
    required CreateBatchUseCase createBatchUseCase,
    required GetAllBatchUseCase getAllBatchUseCase,
    required DeleteBatchUseCase deleteBatchUseCase,
  })  : _createBatchUseCase = createBatchUseCase,
        _getAllBatchUseCase = getAllBatchUseCase,
        _deleteBatchUseCase = deleteBatchUseCase,
        super(BatchState.initial()) {
    on<LoadBatches>(_onLoadBatches);
    on<AddBatch>(_onAddBatch);
    on<DeleteBatch>(_onDeleteBatch);

    // Trigger initial batch loading
    add(LoadBatches());
  }

  Future<void> _onLoadBatches(
      LoadBatches event, Emitter<BatchState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllBatchUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) =>
          emit(state.copyWith(isLoading: false, error: null, batches: batches)),
    );
  }

  Future<void> _onAddBatch(AddBatch event, Emitter<BatchState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createBatchUseCase
        .call(CreateBatchParams(batchName: event.batchName));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadBatches());
      },
    );
  }

  Future<void> _onDeleteBatch(
      DeleteBatch event, Emitter<BatchState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteBatchUseCase
        .call(DeleteBatchParams(batchId: event.batchId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadBatches());
      },
    );
  }
}
