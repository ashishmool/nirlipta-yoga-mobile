import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nirlipta_yoga_mobile/features/auth/domain/entity/user_entity.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/user_repository.dart';

class GetUserByIdParams extends Equatable {
  final String id;

  const GetUserByIdParams({required this.id});

  const GetUserByIdParams.empty() : id = "_empty.string";

  @override
  List<Object?> get props => [id];
}

class GetUserByIdUsecase implements UsecaseWithParams<void, GetUserByIdParams> {
  final IUserRepository userRepository;

  const GetUserByIdUsecase({required this.userRepository});

  @override
  Future<Either<Failure, UserEntity>> call(GetUserByIdParams params) async {
    return await userRepository.getUserById(params.id);
  }
}
