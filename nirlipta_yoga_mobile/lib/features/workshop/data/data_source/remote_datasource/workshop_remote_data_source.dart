import 'package:dio/dio.dart';

import '../../../../../app/constants/api_endpoints.dart';
import '../../../domain/entity/workshop_entity.dart';
import '../../model/workshop_api_model.dart';

class WorkshopRemoteDataSource {
  final Dio _dio;

  WorkshopRemoteDataSource(this._dio);

  Future<void> createWorkshop(WorkshopEntity workshop) async {
    try {
      // Convert entity to model
      var workshopApiModel = WorkshopApiModel.fromEntity(workshop);
      var response = await _dio.post(
        ApiEndpoints.createWorkshop,
        data: workshopApiModel.toJson(),
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

  Future<List<WorkshopEntity>> getAllWorkshops() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllWorkshops);
      if (response.statusCode == 200) {
        var data = response.data as List<dynamic>;
        return data
            .map((workshop) => WorkshopApiModel.fromJson(workshop).toEntity())
            .toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<WorkshopEntity> getWorkshopById(String workshopId) async {
    try {
      var response =
          await _dio.get('${ApiEndpoints.getWorkshopById}/$workshopId');
      if (response.statusCode == 200) {
        return WorkshopApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateWorkshop(WorkshopEntity workshopEntity) async {
    try {
      var workshopApiModel = WorkshopApiModel.fromEntity(workshopEntity);
      var response = await _dio.put(
        '${ApiEndpoints.updateWorkshop}/${workshopEntity.id}',
        data: workshopApiModel.toJson(),
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

  Future<void> deleteWorkshop(String workshopId) async {
    try {
      var response =
          await _dio.delete('${ApiEndpoints.deleteWorkshop}/$workshopId');
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
}
