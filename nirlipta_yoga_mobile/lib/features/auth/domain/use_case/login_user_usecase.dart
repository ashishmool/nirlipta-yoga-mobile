import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nirlipta_yoga_mobile/app/shared_prefs/token_shared_prefs.dart';

import '../../../../app/shared_prefs/user_shared_prefs.dart';
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

  const LoginUserParams.empty()
      : email = '_empty.email',
        password = '_empty.password';

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

class LoginUserUsecase
    implements UsecaseWithParams<List<String>, LoginUserParams> {
  final IUserRepository userRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final UserSharedPrefs userSharedPrefs;

  const LoginUserUsecase(
      {required this.userRepository,
      required this.tokenSharedPrefs,
      required this.userSharedPrefs});

  // @override
  // Future<Either<Failure, String>> call(LoginUserParams params) async {
  //   //Save token in Shared Preferences
  //   return userRepository.login(params.email, params.password).then((value) {
  //     return value.fold(
  //       (failure) => Left(failure),
  //       (token) {
  //         tokenSharedPrefs.saveToken(token);
  //         // // To check and match Token
  //         // tokenSharedPrefs.getToken().then((value) {
  //         //   print(value);
  //         // });
  //         return Right(token);
  //       },
  //     );
  //   });
  // }

  @override
  Future<Either<Failure, List<String>>> call(LoginUserParams params) async {
    // Call the repository to login
    return userRepository.login(params.email, params.password).then((value) {
      return value.fold(
        (failure) => Left(failure),
        (userData) {
          // Save user data in Shared Preferences
          userSharedPrefs.setUserData(userData as List<String>).then((_) {
            // Print the response fields
            print('User Data Saved:');
            print('Success: ${userData[0]}');
            print('Token: ${userData[1]}');
            print('User ID: ${userData[2]}');
            print('Photo: ${userData[3]}');
            print('Email: ${userData[4]}');
            print('Role: ${userData[5]}');
            print('Message: ${userData[6]}');
            print('Status Code: ${userData[7]}');
          });
          return Right(userData as List<String>);
        },
      );
    });
  }
}
