import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/user_entity.dart';
import '../repository/student_repository.dart';

class GetAllStudentUsecase implements UsecaseWithoutParams {
  final IStudentRepository studentRepository;

  const GetAllStudentUsecase({required this.studentRepository});

  @override
  Future<Either<Failure, List<StudentEntity>>> call() {
    return studentRepository.getAllStudents();
  }
}
