import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/enrollment_entity.dart';
import '../../domain/repository/enrollment_repository.dart';
import '../data_source/remote_datasource/enrollment_remote_data_source.dart';

class EnrollmentRemoteRepository implements IEnrollmentRepository {
  final EnrollmentRemoteDataSource _enrollmentRemoteDataSource;

  EnrollmentRemoteRepository(this._enrollmentRemoteDataSource);

  @override
  Future<Either<Failure, void>> createEnrollment(
      EnrollmentEntity enrollment) async {
    try {
      await _enrollmentRemoteDataSource.createEnrollment(enrollment);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: 'Error creating enrollment: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEnrollment(
      String id, String? token) async {
    try {
      await _enrollmentRemoteDataSource.deleteEnrollment(id, token);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: 'Error deleting enrollment: $e'));
    }
  }

  @override
  Future<Either<Failure, List<EnrollmentEntity>>> getAllEnrollments() async {
    try {
      final enrollments = await _enrollmentRemoteDataSource.getAllEnrollments();
      return Right(enrollments);
    } catch (e) {
      return Left(ApiFailure(message: 'Error fetching all enrollments: $e'));
    }
  }

  @override
  Future<Either<Failure, EnrollmentEntity>> getEnrollmentById(String id) async {
    try {
      final enrollment =
          await _enrollmentRemoteDataSource.getEnrollmentById(id);
      return Right(enrollment);
    } catch (e) {
      return Left(ApiFailure(message: 'Error fetching enrollment by ID: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateEnrollment(
      EnrollmentEntity enrollment, String? token) async {
    try {
      await _enrollmentRemoteDataSource.updateEnrollment(enrollment);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: 'Error updating enrollment: $e'));
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
//         await _enrollmentRemoteDataSource.getEnrollmentByUser(userId);
//
//     return Right(
//         [enrollments]); // Ensure this returns a List<EnrollmentEntity>
//   } catch (e) {
//     return Left(
//         ApiFailure(message: 'Error fetching enrollments by user ID: $e'));
//   }
// }
}
