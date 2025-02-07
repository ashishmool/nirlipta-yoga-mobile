import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/workshop_entity.dart';
import '../../domain/repository/workshop_repository.dart';
import '../data_source/remote_datasource/workshop_remote_data_source.dart';

class WorkshopRemoteRepository implements IWorkshopRepository {
  final WorkshopRemoteDataSource _workshopRemoteDataSource;

  WorkshopRemoteRepository({
    required WorkshopRemoteDataSource workshopRemoteDataSource,
  }) : _workshopRemoteDataSource = workshopRemoteDataSource;

  @override
  Future<Either<Failure, void>> createWorkshop(WorkshopEntity workshop) async {
    try {
      await _workshopRemoteDataSource.createWorkshop(workshop);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: 'Error creating workshop: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteWorkshop(
      String workshopId, String? token) async {
    try {
      await _workshopRemoteDataSource.deleteWorkshop(workshopId, token);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: 'Error deleting workshop: $e'));
    }
  }

  @override
  Future<Either<Failure, List<WorkshopEntity>>> getAllWorkshops() async {
    try {
      final workshops = await _workshopRemoteDataSource.getAllWorkshops();
      return Right(workshops);
    } catch (e) {
      return Left(ApiFailure(message: 'Error fetching all workshops: $e'));
    }
  }

  @override
  Future<Either<Failure, WorkshopEntity>> getWorkshopById(
      String workshopId) async {
    try {
      final workshop =
          await _workshopRemoteDataSource.getWorkshopById(workshopId);
      return Right(workshop);
    } catch (e) {
      return Left(ApiFailure(message: 'Error fetching workshop by ID: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateWorkshop(
      WorkshopEntity workshop, String? token) async {
    try {
      await _workshopRemoteDataSource.updateWorkshop(workshop, token);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: 'Error updating workshop: $e'));
    }
  }
}
