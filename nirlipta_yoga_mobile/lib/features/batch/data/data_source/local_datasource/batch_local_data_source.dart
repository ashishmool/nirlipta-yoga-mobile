import '../../../../../core/network/hive_service.dart';
import '../../../domain/entity/batch_entity.dart';
import '../../model/batch_hive_model.dart';
import '../batch_data_source.dart';

class BatchLocalDataSource implements IBatchDataSource {
  // Since we have two local sources we need to force using
  final HiveService _hiveService;

  BatchLocalDataSource(this._hiveService);

  @override
  Future<void> createBatch(BatchEntity batchEntity) async {
    try {
      // Convert BatchEntity to Batch Hive Model
      final batchHiveModel = BatchHiveModel.fromEntity(batchEntity);
      await _hiveService.addBatch(batchHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteBatch(String batchId) async {
    try {
      return await _hiveService.deleteBatch(batchId);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<BatchEntity>> getAllBatches() {
    try {
      return _hiveService.getAllBatches().then((value) {
        //Conversion Logic i.e. fetched is sent to Entity and then listed
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
