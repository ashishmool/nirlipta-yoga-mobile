import 'package:dio/dio.dart';

import '../../../../../app/constants/api_endpoints.dart';
import '../../../domain/entity/user_entity.dart';
import '../../model/user_api_model.dart';

class UserRemoteDataSource {
  final Dio _dio;

  UserRemoteDataSource(this._dio);

  /// Creates a new user
  Future<void> createUser(UserEntity userEntity) async {
    try {
      // Convert entity to model
      var userApiModel = UserApiModel.fromEntity(userEntity);
      var response = await _dio.post(
        ApiEndpoints.register,
        data: userApiModel.toJson(),
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

  /// Deletes a user by ID
  Future<void> deleteUser(String userId) async {
    try {
      var response = await _dio.delete(
        '${ApiEndpoints.deleteUser}/$userId',
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

  /// Gets all users
  Future<List<UserEntity>> getAllUsers() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllUsers);
      if (response.statusCode == 200) {
        var data = response.data as List<dynamic>;
        return data
            .map((user) => UserApiModel.fromJson(user).toEntity())
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

  /// Logs in a user
  Future<UserEntity> login(String email, String password) async {
    try {
      var response = await _dio.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        return UserApiModel.fromJson(response.data).toEntity();
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
