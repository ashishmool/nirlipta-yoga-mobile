import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/enrollment_entity.dart';
import '../../domain/repository/enrollment_repository.dart';
import '../data_source/local_datasource/enrollment_local_data_source.dart';

class EnrollmentLocalRepository implements IEnrollmentRepository {
  final EnrollmentLocalDataSource _enrollmentLocalDataSource;

  EnrollmentLocalRepository({
    required EnrollmentLocalDataSource enrollmentLocalDataSource,
  }) : _enrollmentLocalDataSource = enrollmentLocalDataSource;

  @override
  Future<Either<Failure, void>> createEnrollment(
      EnrollmentEntity enrollment) async {
    try {
      await _enrollmentLocalDataSource.createEnrollment(enrollment);
      return Right(null);
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'Error creating enrollment: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEnrollment(
      String id, String? token) async {
    try {
      await _enrollmentLocalDataSource.deleteEnrollment(id, token);
      return Right(null);
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'Error deleting enrollment: $e'));
    }
  }

  @override
  Future<Either<Failure, EnrollmentEntity>> getEnrollmentById(String id) async {
    try {
      final enrollment = await _enrollmentLocalDataSource.getEnrollmentById(id);
      return Right(enrollment);
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'Error fetching enrollment by ID: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateEnrollment(
      EnrollmentEntity enrollment, String? token) async {
    try {
      await _enrollmentLocalDataSource.updateEnrollment(enrollment);
      return Right(null);
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'Error updating enrollment: $e'));
    }
  }

  @override
  Future<Either<Failure, List<EnrollmentEntity>>> getAllEnrollments() async {
    try {
      final enrollments = await _enrollmentLocalDataSource.getAllEnrollments();
      return Right(enrollments);
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'Error fetching all enrollments: $e'));
    }
  }

  @override
  Future<Either<Failure, List<EnrollmentEntity>>> getEnrollmentByUser(
      String userId) {
    // TODO: implement getEnrollmentByUser
    throw UnimplementedError();
  }

// @override
// Future<Either<Failure, List<EnrollmentEntity>>> getEnrollmentByUser(
//     String userId) async {
//   try {
//     final enrollments =
//         await _enrollmentLocalDataSource.getEnrollmentByUser(userId);
//
//     return Right(enrollments);
//   } catch (e) {
//     return Left(
//         ApiFailure(message: 'Error fetching enrollments by user ID: $e'));
//   }
// }
}
