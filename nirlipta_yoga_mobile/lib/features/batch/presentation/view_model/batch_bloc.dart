import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/batch_entity.dart';

part 'batch_event.dart';
part 'batch_state.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  BatchBloc() : super(BatchState.initial()) {
    on<LoadBatches>(_onLoadBatches);
    on<AddBatch>(_onAddBatch);
    on<DeleteBatch>(_onDeleteBatch);
  }

  Future<void> _onLoadBatches(
      LoadBatches event, Emitter<BatchState> emit) async {}

  Future<void> _onAddBatch(AddBatch event, Emitter<BatchState> emit) async {}

  Future<void> _onDeleteBatch(
      DeleteBatch event, Emitter<BatchState> emit) async {}
}
