import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/workshop_entity.dart';
import '../../domain/repository/workshop_repository.dart';
import '../data_source/local_datasource/workshop_local_data_source.dart';

class WorkshopLocalRepository implements IWorkshopRepository {
  final WorkshopLocalDataSource _workshopLocalDataSource;

  WorkshopLocalRepository({
    required WorkshopLocalDataSource workshopLocalDataSource,
  }) : _workshopLocalDataSource = workshopLocalDataSource;

  @override
  Future<Either<Failure, void>> createWorkshop(WorkshopEntity workshop) async {
    try {
      await _workshopLocalDataSource.createWorkshop(workshop);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Error creating workshop: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteWorkshop(String workshopId) async {
    try {
      await _workshopLocalDataSource.deleteWorkshop(workshopId);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Error deleting workshop: $e'));
    }
  }

  @override
  Future<Either<Failure, List<WorkshopEntity>>> getAllWorkshops() async {
    try {
      final workshops = await _workshopLocalDataSource.getAllWorkshops();
      return Right(workshops);
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'Error fetching all workshops: $e'));
    }
  }

  @override
  Future<Either<Failure, WorkshopEntity>> getWorkshopById(
      String workshopId) async {
    try {
      final workshop =
          await _workshopLocalDataSource.getWorkshopById(workshopId);
      return Right(workshop);
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'Error fetching workshop by ID: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateWorkshop(WorkshopEntity workshop) async {
    try {
      await _workshopLocalDataSource.updateWorkshop(workshop);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Error updating workshop: $e'));
    }
  }
}
