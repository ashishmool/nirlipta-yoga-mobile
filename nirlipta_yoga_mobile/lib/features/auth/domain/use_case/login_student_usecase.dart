import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/student_repository.dart';

class LoginStudentParams extends Equatable {
  final String email;
  final String password;

  const LoginStudentParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

class LoginStudentUsecase
    implements UsecaseWithParams<void, LoginStudentParams> {
  final IStudentRepository studentRepository;

  const LoginStudentUsecase({required this.studentRepository});

  @override
  Future<Either<Failure, void>> call(LoginStudentParams params) async {
    return await studentRepository.login(params.email, params.password);
  }
}
