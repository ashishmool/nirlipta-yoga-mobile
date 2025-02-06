import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nirlipta_yoga_mobile/app/shared_prefs/token_shared_prefs.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class GetAllUserParams extends Equatable {
  final String? token;

  const GetAllUserParams({this.token});

  const GetAllUserParams.empty() : token = null;

  @override
  List<Object?> get props => [token];
}

class GetAllUserUsecase
    implements UsecaseWithParams<List<UserEntity>, GetAllUserParams> {
  final IUserRepository userRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  const GetAllUserUsecase({
    required this.userRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> call(
      GetAllUserParams params) async {
    // Use the provided token if available; otherwise, retrieve from shared preferences.
    String? token = params.token;

    if (token == null || token.isEmpty) {
      final tokenResult = await tokenSharedPrefs.getToken();

      token = tokenResult.fold(
          (failure) => null, (retrievedToken) => retrievedToken);
    }

    if (token == null || token.isEmpty) {
      return Left(ApiFailure(message: "Token not found"));
    }

    return await userRepository.getAllUsers(token);
  }
}
