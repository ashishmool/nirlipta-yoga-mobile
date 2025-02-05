import 'package:dio/dio.dart';

import '../../../../../app/constants/api_endpoints.dart';
import '../../../domain/entity/category_entity.dart';
import '../../model/category_api_model.dart';

class CategoryRemoteDataSource {
  final Dio _dio;

  CategoryRemoteDataSource(this._dio);

  Future<void> createCategory(CategoryEntity category) async {
    try {
      // Convert entity to model
      var categoryApiModel = CategoryApiModel.fromEntity(category);
      var response = await _dio.post(
        ApiEndpoints.createCategory,
        data: categoryApiModel.toJson(),
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

  Future<List<CategoryEntity>> getAllCategories() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllCategories);
      if (response.statusCode == 200) {
        var data = response.data as List<dynamic>;
        return data
            .map((category) => CategoryApiModel.fromJson(category).toEntity())
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

  Future<CategoryEntity> getCategoryById(String id) async {
    try {
      var response = await _dio.get('${ApiEndpoints.getCategoryById}/$id');
      if (response.statusCode == 200) {
        return CategoryApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateCategory(CategoryEntity categoryEntity) async {
    try {
      var categoryApiModel = CategoryApiModel.fromEntity(categoryEntity);
      var response = await _dio.put(
        '${ApiEndpoints.updateCategory}/${categoryEntity.id}',
        data: categoryApiModel.toJson(),
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

  Future<void> deleteCategory(String id, String? token) async {
    try {
      var response = await _dio.delete('${ApiEndpoints.deleteCategory}/$id');
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
