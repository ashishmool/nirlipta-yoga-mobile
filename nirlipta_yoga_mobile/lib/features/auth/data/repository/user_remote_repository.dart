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
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final users = await _userRemoteDataSource.getAllUsers();
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
  Future<Either<Failure, UserEntity>> login(
      String email, String password) async {
    try {
      // Call the login function and get the LoginResponseEntity
      final loginResponse = await _userRemoteDataSource.login(email, password);

      // Extract the UserEntity from the LoginResponseEntity
      final user = loginResponse.user;

      // Return the UserEntity as a Right value
      return Right(user);
    } catch (e) {
      // Handle any errors and return the failure message
      return Left(
        LocalDatabaseFailure(
          message: 'Login failed: $e',
        ),
      );
    }
  }
}
