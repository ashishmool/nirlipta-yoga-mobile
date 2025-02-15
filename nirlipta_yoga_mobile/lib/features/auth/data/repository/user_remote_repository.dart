import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../data_source/remote_datasource/user_remote_data_source.dart';

class UserRemoteRepository implements IUserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRemoteRepository(this._userRemoteDataSource);

  @override
  Future<Either<Failure, void>> createUser(UserEntity userEntity) async {
    try {
      await _userRemoteDataSource.createUser(userEntity);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: 'Error creating user: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers(String token) async {
    try {
      final users = await _userRemoteDataSource.getAllUsers(token);
      return Right(users);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(
          message: 'Error fetching all users: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String id) async {
    try {
      await _userRemoteDataSource.deleteUser(id);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: 'Error deleting user: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      // Call the login function and get the LoginResponseEntity
      final token = await _userRemoteDataSource.login(email, password);

      // Return the UserEntity as a Right value
      return Right(token);
    } catch (e) {
      // Handle any errors and return the failure message
      return Left(
        ApiFailure(
          message: 'Login Failed: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(File file) async {
    try {
      return Right(await _userRemoteDataSource.uploadImage(file));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(String id) async {
    try {
      final user = await _userRemoteDataSource.getUserById(id);
      return Right(user); // Successfully fetched user
    } catch (e) {
      return Left(ApiFailure(
          message: e
              .toString())); // Handle error (ServerFailure can be customized to represent different types of failures)
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(UserEntity userEntity) async {
    try {
      await _userRemoteDataSource.updateUser(userEntity);
      return const Right(null); // Successfully updated user
    } catch (e) {
      return Left(ApiFailure(
          message:
              e.toString())); // Handle error (ServerFailure can be customized)
    }
  }
}
