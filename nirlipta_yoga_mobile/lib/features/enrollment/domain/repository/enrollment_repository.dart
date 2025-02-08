import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/enrollment_entity.dart';

abstract interface class IEnrollmentRepository {
  Future<Either<Failure, void>> createEnrollment(
      EnrollmentEntity enrollmentEntity);

  Future<Either<Failure, List<EnrollmentEntity>>> getAllEnrollments();

  Future<Either<Failure, EnrollmentEntity>> getEnrollmentById(String id);

  // Future<Either<Failure, List<EnrollmentEntity>>> getEnrollmentByUser(
  //     String userId);

  Future<Either<Failure, void>> updateEnrollment(
      EnrollmentEntity enrollmentEntity, String? token);

  Future<Either<Failure, void>> deleteEnrollment(String id, String? token);
}
