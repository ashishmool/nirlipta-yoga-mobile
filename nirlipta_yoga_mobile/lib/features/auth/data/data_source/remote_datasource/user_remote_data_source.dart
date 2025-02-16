import 'dart:io';

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
  Future<List<UserEntity>> getAllUsers(String token) async {
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
  @override
  Future<List<String>> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      // Check if response is not null and has statusCode 200
      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data;

        // Extract all required fields from the response
        final success = responseData['success']?.toString() ?? '';
        final token = responseData['token']?.toString() ?? '';
        final userId = responseData['user_id']?.toString() ?? '';
        final photo = responseData['photo']?.toString() ?? '';
        final email = responseData['email']?.toString() ?? '';
        final role = responseData['role']?.toString() ?? '';
        final message = responseData['message']?.toString() ?? '';
        final statusCode = responseData['statusCode']?.toString() ?? '';

        // Return the fields as a List<String>
        return [
          success,
          token,
          userId,
          photo,
          email,
          role,
          message,
          statusCode
        ];
      } else {
        throw Exception('Invalid response: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message ?? 'Unknown error'}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  //Upload Image
  Future<String> uploadImage(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "profilePicture":
            await MultipartFile.fromFile(file.path, filename: fileName)
      });

      Response response =
          await _dio.post(ApiEndpoints.uploadImage, data: formData);

      if (response.statusCode == 200) {
        // Return Image Path from Server
        return response.data['data'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Network error during profile upload: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // Get user by ID
  Future<UserEntity> getUserById(String userId) async {
    try {
      var response = await _dio.get('${ApiEndpoints.getUserById}$userId');
      if (response.statusCode == 200) {
        var data = response.data;
        var user = UserApiModel.fromJson(data).toEntity();
        return user;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // Update user
  Future<void> updateUser(UserEntity userEntity) async {
    try {
      var userApiModel = UserApiModel.fromEntity(userEntity);
      var response = await _dio.put(
        ApiEndpoints.updateUser,
        data: userApiModel.toJson(),
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
