import 'package:dio/dio.dart';

import '../../../../../app/constants/api_endpoints.dart';
import '../../../domain/entity/login_response_entity.dart';
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
  Future<LoginResponseEntity> login(String email, String password) async {
    try {
      var response = await _dio.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      print('Response Data: ${response.data}');

      // Check if response is not null and has statusCode 200
      if (response.statusCode == 200 && response.data != null) {
        var responseData = response.data;

        // Ensure the response contains necessary data, including 'token'
        String? token = responseData['token'];
        String? userId = responseData['user_id'];
        String? email = responseData['email'];
        String? role = responseData['role'];
        String? photo = responseData['photo']; // Null is allowed here

        if (token != null && userId != null && email != null && role != null) {
          // Safely handle nullable fields
          return LoginResponseEntity(
            user: UserEntity(
              id: userId,
              email: email,
              photo: photo ?? '',
              name: '',
              username: '',
              phone: '',
              password: '',
              medical_conditions: '',
              gender: '', // Default to empty string if null
            ),
            token: token,
          );
        } else {
          throw Exception(
              'Response does not contain valid token, user_id, email, or role');
        }
      } else {
        throw Exception('Invalid response: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message ?? 'Unknown error'}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}

