import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/retreat_entity.dart';

abstract interface class IRetreatRepository {
  // Create a new retreat
  Future<Either<Failure, void>> createRetreat(RetreatEntity retreatEntity);

  // Get all retreats
  Future<Either<Failure, List<RetreatEntity>>> getAllRetreats();

  // Get a retreat by ID
  Future<Either<Failure, RetreatEntity>> getRetreatById(String retreatId);

  // Update a retreat by ID
  Future<Either<Failure, void>> updateRetreat(
      String retreatId, RetreatEntity retreatEntity);

  // Partially update a retreat by ID
  Future<Either<Failure, void>> patchRetreat(
      String retreatId, RetreatEntity retreatEntity);

  // Delete a retreat by ID
  Future<Either<Failure, void>> deleteRetreat(String retreatId);
}
