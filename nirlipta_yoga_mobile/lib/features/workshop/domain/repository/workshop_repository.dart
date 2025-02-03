import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/workshop_entity.dart';

abstract interface class IWorkshopRepository {
  Future<Either<Failure, void>> createWorkshop(WorkshopEntity workshopEntity);

  Future<Either<Failure, List<WorkshopEntity>>> getAllWorkshops();

  Future<Either<Failure, WorkshopEntity>> getWorkshopById(String workshopId);

  Future<Either<Failure, void>> updateWorkshop(WorkshopEntity workshopEntity);

  Future<Either<Failure, void>> deleteWorkshop(
      String workshopId, String? token);
}
