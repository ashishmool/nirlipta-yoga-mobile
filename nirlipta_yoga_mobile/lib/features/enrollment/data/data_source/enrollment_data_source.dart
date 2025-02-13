import '../../domain/entity/enrollment_entity.dart';

abstract interface class IEnrollmentDataSource {
  Future<void> createEnrollment(EnrollmentEntity enrollmentEntity);

  Future<List<EnrollmentEntity>> getAllEnrollments();

  Future<EnrollmentEntity> getEnrollmentById(String id);

  Future<List<EnrollmentEntity>> getEnrollmentByUser(String userId);

  Future<void> updateEnrollment(EnrollmentEntity enrollmentEntity);

  Future<void> deleteEnrollment(String id, String? token);
}
