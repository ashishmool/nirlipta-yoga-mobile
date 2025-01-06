import '../../domain/entity/retreat_entity.dart';

abstract interface class IRetreatDataSource {
  // Create a new retreat
  Future<void> createRetreat(RetreatEntity retreatEntity);

  // Get all retreats
  Future<List<RetreatEntity>> getAllRetreats();

  // Get a retreat by ID
  Future<RetreatEntity> getRetreatById(String retreatId);

  // Update a retreat by ID
  Future<void> updateRetreat(String retreatId, RetreatEntity retreatEntity);

  // Partially update a retreat by ID
  Future<void> patchRetreat(String retreatId, RetreatEntity retreatEntity);

  // Delete a retreat by ID
  Future<void> deleteRetreat(String retreatId);
}
