import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/user_entity.dart';

abstract interface class IStudentRepository {
  Future<Either<Failure, void>> createStudent(StudentEntity studentEntity);

  Future<Either<Failure, List<StudentEntity>>> getAllStudents();

  Future<Either<Failure, void>> deleteStudent(String id);

  Future<Either<Failure, StudentEntity>> login(String email, String password);
}
