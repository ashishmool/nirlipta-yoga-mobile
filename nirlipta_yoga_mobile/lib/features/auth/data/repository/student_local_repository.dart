import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/student_repository.dart';
import '../data_source/local_datasource/student_local_datasource.dart';

class StudentLocalRepository implements IStudentRepository {
  final StudentLocalDatasource _studentLocalDataSource;

  StudentLocalRepository(
      {required StudentLocalDatasource studentLocalDataSource})
      : _studentLocalDataSource = studentLocalDataSource;

  @override
  Future<Either<Failure, void>> createStudent(StudentEntity studentEntity) {
    try {
      _studentLocalDataSource.createStudent(studentEntity);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudent(String id) async {
    try {
      await _studentLocalDataSource.deleteStudent(id);
      return Right(null);
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> getAllStudents() async {
    try {
      final List<StudentEntity> students =
          await _studentLocalDataSource.getAllStudents();
      return Right(students);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StudentEntity>> login(
      String email, String password) async {
    try {
      final student = await _studentLocalDataSource.login(email, password);
      return (Right(student));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
