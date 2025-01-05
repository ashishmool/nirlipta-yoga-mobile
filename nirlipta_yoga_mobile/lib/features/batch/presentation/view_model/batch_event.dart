part of 'batch_bloc.dart';

@immutable
sealed class BatchEvent extends Equatable {
  const BatchEvent();

  @override
  List<Object> get props => [];
}

final class LoadBatches extends BatchEvent {}

final class AddBatch extends BatchEvent {
  final String batchName;
  const AddBatch(this.batchName);

  @override
  List<Object> get props => [batchName];
}

final class DeleteBatch extends BatchEvent {
  final String batchId;

  const DeleteBatch(this.batchId);

  @override
  List<Object> get props => [batchId];
}
