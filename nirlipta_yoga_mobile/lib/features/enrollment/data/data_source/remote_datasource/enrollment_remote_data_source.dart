import 'package:dio/dio.dart';
import 'package:nirlipta_yoga_mobile/features/enrollment/data/data_source/enrollment_data_source.dart';
import 'package:nirlipta_yoga_mobile/features/enrollment/data/dto/get_all_enrollment_dto.dart';

import '../../../../../app/constants/api_endpoints.dart';
import '../../../domain/entity/enrollment_entity.dart';
import '../../model/enrollment_api_model.dart';

class EnrollmentRemoteDataSource implements IEnrollmentDataSource {
  final Dio _dio;

  EnrollmentRemoteDataSource(this._dio);

  @override
  Future<void> createEnrollment(EnrollmentEntity enrollment) async {
    try {
      // Convert entity to model
      var enrollmentApiModel = EnrollmentApiModel.fromEntity(enrollment);
      var response = await _dio.post(
        ApiEndpoints.createEnrollment,
        data: enrollmentApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<EnrollmentEntity>> getAllEnrollments() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllEnrollments);
      print('Raw Response Data: ${response.data}'); // ✅ Debugging step

      if (response.statusCode == 200) {
        // Parse response
        GetAllEnrollmentDTO enrollmentAddDTO =
            GetAllEnrollmentDTO.fromJson(response.data);

        print(
            'Parsed DTO Enrollments: ${enrollmentAddDTO.enrollments}'); // ✅ Debugging

        return EnrollmentApiModel.toEntityList(enrollmentAddDTO.enrollments);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception('Error in getAllEnrollments: $e');
    }
  }

  @override
  Future<EnrollmentEntity> getEnrollmentById(String id) async {
    try {
      var response = await _dio.get('${ApiEndpoints.getEnrollmentById}/$id');
      if (response.statusCode == 200) {
        return EnrollmentApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateEnrollment(EnrollmentEntity enrollmentEntity) async {
    try {
      var enrollmentApiModel = EnrollmentApiModel.fromEntity(enrollmentEntity);
      var response = await _dio.put(
        '${ApiEndpoints.updateEnrollment}/${enrollmentEntity.id}',
        data: enrollmentApiModel.toJson(),
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteEnrollment(String id, String? token) async {
    try {
      var response = await _dio.delete('${ApiEndpoints.deleteEnrollment}/$id');
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<EnrollmentEntity>> getEnrollmentByUser(String userId) async {
    try {
      var response = await _dio.get('${ApiEndpoints.getEnrollment}/$userId');

      if (response.statusCode == 200) {
        // Ensure response.data is a list before mapping
        if (response.data is List) {
          return response.data
              .map<EnrollmentEntity>(
                  (e) => EnrollmentApiModel.fromJson(e).toEntity())
              .toList();
        } else {
          throw Exception("Unexpected response format: Not a list");
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
