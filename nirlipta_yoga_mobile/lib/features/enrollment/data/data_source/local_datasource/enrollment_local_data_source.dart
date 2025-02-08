import '../../../../../core/network/hive_service.dart';
import '../../../domain/entity/enrollment_entity.dart';
import '../../model/enrollment_hive_model.dart';
import '../enrollment_data_source.dart';

class EnrollmentLocalDataSource implements IEnrollmentDataSource {
  final HiveService _hiveService;

  EnrollmentLocalDataSource(this._hiveService);

  @override
  Future<void> createEnrollment(EnrollmentEntity enrollmentEntity) async {
    try {
      final enrollmentHiveModel =
          EnrollmentHiveModel.fromEntity(enrollmentEntity);
      await _hiveService.addEnrollment(enrollmentHiveModel);
    } catch (e) {
      throw Exception('Error creating enrollment: $e');
    }
  }

  @override
  Future<void> deleteEnrollment(String id, String? token) async {
    try {
      await _hiveService.deleteEnrollment(id);
    } catch (e) {
      throw Exception('Error deleting enrollment: $e');
    }
  }

  @override
  Future<List<EnrollmentEntity>> getAllEnrollments() async {
    try {
      final enrollments = await _hiveService.getAllEnrollments();
      return enrollments.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Error fetching all enrollments: $e');
    }
  }

  @override
  Future<EnrollmentEntity> getEnrollmentById(String id) async {
    try {
      final enrollmentHiveModel = await _hiveService.getEnrollmentById(id);
      if (enrollmentHiveModel != null) {
        return enrollmentHiveModel.toEntity();
      } else {
        throw Exception('Enrollment not found');
      }
    } catch (e) {
      throw Exception('Error fetching enrollment by ID: $e');
    }
  }

  @override
  Future<List<EnrollmentEntity>> getEnrollmentByUser(String userId) {
    try {
      return _hiveService.getEnrollmentById(userId).then((value) {
        if (value != null) {
          return [value.toEntity()]; // Wrap the single entity in a list
        } else {
          throw Exception('Enrollment not found');
        }
      });
    } catch (e) {
      throw Exception('Error fetching enrollment by ID: $e');
    }
  }

  @override
  Future<void> updateEnrollment(EnrollmentEntity enrollmentEntity) async {
    try {
      final enrollmentHiveModel =
          EnrollmentHiveModel.fromEntity(enrollmentEntity);
      await _hiveService.updateEnrollment(enrollmentHiveModel);
    } catch (e) {
      throw Exception('Error updating enrollment: $e');
    }
  }
}
