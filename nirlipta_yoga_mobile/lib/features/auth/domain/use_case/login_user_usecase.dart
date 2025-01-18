import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/user_repository.dart';

class LoginUserParams extends Equatable {
  final String email;
  final String password;

  const LoginUserParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

class LoginUserUsecase implements UsecaseWithParams<void, LoginUserParams> {
  final IUserRepository userRepository;

  const LoginUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(LoginUserParams params) async {
    return await userRepository.login(params.email, params.password);
  }
}
