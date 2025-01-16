import '../../../../../core/network/hive_service.dart';
import '../../../domain/entity/workshop_entity.dart';
import '../../model/workshop_hive_model.dart';
import '../workshop_data_source.dart';

class WorkshopLocalDataSource implements IWorkshopDataSource {
  final HiveService _hiveService;

  WorkshopLocalDataSource(this._hiveService);

  @override
  Future<void> createWorkshop(WorkshopEntity workshopEntity) async {
    try {
      final workshopHiveModel = WorkshopHiveModel.fromEntity(workshopEntity);
      await _hiveService.addWorkshop(workshopHiveModel);
    } catch (e) {
      throw Exception('Error creating workshop: $e');
    }
  }

  @override
  Future<void> deleteWorkshop(String workshopId) async {
    try {
      await _hiveService.deleteWorkshop(workshopId);
    } catch (e) {
      throw Exception('Error deleting workshop: $e');
    }
  }

  @override
  Future<List<WorkshopEntity>> getAllWorkshops() async {
    try {
      final workshops = await _hiveService.getAllWorkshops();
      return workshops.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Error fetching all workshops: $e');
    }
  }

  @override
  Future<WorkshopEntity> getWorkshopById(String workshopId) async {
    try {
      final workshopHiveModel = await _hiveService.getWorkshopById(workshopId);
      if (workshopHiveModel != null) {
        return workshopHiveModel.toEntity();
      } else {
        throw Exception('Workshop not found');
      }
    } catch (e) {
      throw Exception('Error fetching workshop by ID: $e');
    }
  }

  @override
  Future<void> updateWorkshop(WorkshopEntity workshopEntity) async {
    try {
      final workshopHiveModel = WorkshopHiveModel.fromEntity(workshopEntity);
      await _hiveService.updateWorkshop(workshopHiveModel);
    } catch (e) {
      throw Exception('Error updating workshop: $e');
    }
  }
}
