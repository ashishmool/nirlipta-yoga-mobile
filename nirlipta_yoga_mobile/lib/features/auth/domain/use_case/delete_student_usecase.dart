import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/student_repository.dart';

class DeleteStudentParams extends Equatable {
  final String id;

  const DeleteStudentParams({required this.id});

  const DeleteStudentParams.empty() : id = "_empty.string";

  @override
  List<Object?> get props => [id];
}

class DeleteStudentUsecase
    implements UsecaseWithParams<void, DeleteStudentParams> {
  final IStudentRepository studentRepository;

  const DeleteStudentUsecase({required this.studentRepository});

  @override
  Future<Either<Failure, void>> call(DeleteStudentParams params) async {
    return await studentRepository.deleteStudent(params.id);
  }
}
