import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/user_repository.dart';

class UploadImageParams {
  final File file;

  const UploadImageParams({
    required this.file,
  });
}

class UploadImageUseCase
    implements UsecaseWithParams<String, UploadImageParams> {
  final IUserRepository _repository;

  UploadImageUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(UploadImageParams params) {
    return _repository.uploadImage(params.file);
  }
}
