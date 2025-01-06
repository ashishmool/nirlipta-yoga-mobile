import '../../../../../core/network/hive_service.dart';
import '../../../domain/entity/retreat_entity.dart';
import '../../model/retreat_hive_model.dart';
import '../retreat_data_source.dart';

class RetreatLocalDataSource implements IRetreatDataSource {
  // Since we have two local sources we need to force using
  final HiveService _hiveService;

  RetreatLocalDataSource(this._hiveService);

  @override
  Future<void> createRetreat(RetreatEntity retreatEntity) async {
    try {
      // Convert RetreatEntity to Retreat Hive Model
      final retreatHiveModel = RetreatHiveModel.fromEntity(retreatEntity);
      await _hiveService.addRetreat(retreatHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteRetreat(String retreatId) async {
    try {
      return await _hiveService.deleteRetreat(retreatId);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<RetreatEntity>> getAllRetreats() async {
    try {
      final retreatHiveModels = await _hiveService.getAllRetreats();
      return retreatHiveModels
          .map((retreatHiveModel) => retreatHiveModel.toEntity())
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<RetreatEntity> getRetreatById(String retreatId) async {
    try {
      final retreatHiveModel = await _hiveService.getRetreatById(retreatId);
      return retreatHiveModel.toEntity();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateRetreat(
      String retreatId, RetreatEntity retreatEntity) async {
    try {
      final retreatHiveModel = RetreatHiveModel.fromEntity(retreatEntity);
      await _hiveService.updateRetreat(retreatId, retreatHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> patchRetreat(
      String retreatId, RetreatEntity retreatEntity) async {
    try {
      final retreatHiveModel = RetreatHiveModel.fromEntity(retreatEntity);
      await _hiveService.patchRetreat(retreatId, retreatHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }
}
