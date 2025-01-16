import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/batch_entity.dart';
import '../../domain/repository/batch_repository.dart';
import '../data_source/local_datasource/batch_local_data_source.dart';

class BatchLocalRepository implements IBatchRepository {
  final BatchLocalDataSource _batchLocalDataSource;

  BatchLocalRepository({required BatchLocalDataSource batchLocalDataSource})
      : _batchLocalDataSource = batchLocalDataSource;

  @override
  Future<Either<Failure, void>> createBatch(BatchEntity batch) {
    try {
      _batchLocalDataSource.createBatch(batch);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBatch(String batchId) async {
    try {
      await _batchLocalDataSource.deleteBatch(batchId);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Error deleting batch: $e'));
    }
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    try {
      final batches = await _batchLocalDataSource.getAllBatches();
      return Right(batches);
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'Error getting all batches: $e'));
    }
  }
}
