import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/batch_entity.dart';

abstract interface class IBatchRepository {
  Future<Either<Failure, void>> createBatch(BatchEntity batchEntity);

  Future<Either<Failure, List<BatchEntity>>> getAllBatches();

  Future<Either<Failure, void>> deleteBatch(String batchId);
}
