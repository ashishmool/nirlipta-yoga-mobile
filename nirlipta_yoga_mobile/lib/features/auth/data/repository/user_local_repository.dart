import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../data_source/local_datasource/user_local_datasource.dart';

class UserLocalRepository implements IUserRepository {
  final UserLocalDatasource _userLocalDataSource;

  UserLocalRepository({required UserLocalDatasource userLocalDataSource})
      : _userLocalDataSource = userLocalDataSource;

  @override
  Future<Either<Failure, void>> createUser(UserEntity userEntity) async {
    try {
      await _userLocalDataSource.createUser(userEntity);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String id) async {
    try {
      await _userLocalDataSource.deleteUser(id);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final List<UserEntity> users = await _userLocalDataSource.getAllUsers();
      return Right(users);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(File file) async {
    try {
      // Placeholder for actual implementation
      return Right('Image Upload Success!!');
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      // Placeholder for actual login implementation
      return Right('Login successful');
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
