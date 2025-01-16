import '../../domain/entity/workshop_entity.dart';

abstract interface class IWorkshopDataSource {
  Future<void> createWorkshop(WorkshopEntity workshopEntity);

  Future<List<WorkshopEntity>> getAllWorkshops();

  Future<WorkshopEntity> getWorkshopById(String workshopId);

  Future<void> updateWorkshop(WorkshopEntity workshopEntity);

  Future<void> deleteWorkshop(String workshopId);
}
