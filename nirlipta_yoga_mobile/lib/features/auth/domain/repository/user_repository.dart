import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/user_entity.dart';

abstract interface class IUserRepository {
  Future<Either<Failure, void>> createUser(UserEntity userEntity);

  Future<Either<Failure, List<UserEntity>>> getAllUsers();

  Future<Either<Failure, void>> deleteUser(String id);

  Future<Either<Failure, String>> login(String email, String password);

  Future<Either<Failure, String>> uploadImage(File file);
}
