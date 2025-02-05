import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/core/error/failure.dart';
import 'package:nirlipta_yoga_mobile/features/auth/domain/use_case/login_user_usecase.dart';

import '../../../workshop_category/domain/use_case/token.mock.dart';
import 'auth_repo.mock.dart';

void main() {
  late AuthRepoMock repository;
  late MockTokenSharedPrefs sharedPrefs;
  late LoginUserUsecase usecase;

  setUp(() {
    repository = AuthRepoMock();
    sharedPrefs = MockTokenSharedPrefs();
    usecase = LoginUserUsecase(
        userRepository: repository, tokenSharedPrefs: sharedPrefs);
  });

  test(
      'should call the [AuthRepo.login] with correct email and password (a3.asis@gmail.com, test12345)',
      () async {
    when(() => repository.login(any(), any())).thenAnswer(
      (invocation) async {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        if (email == 'a3.asis@gmail.com' && password == 'test12345') {
          return Future.value(const Right('token'));
        } else {
          return Future.value(
              Left(ApiFailure(message: 'Invalid email or password')));
        }
      },
    );

    when(() => sharedPrefs.saveToken(any())).thenAnswer(
      (_) async => Right(null),
    );

    final result = await usecase(
        LoginUserParams(email: 'a3.asis@gmail.com', password: 'test12345'));

    expect(result, const Right('token'));

    verify(() => repository.login(any(), any())).called(1);
    verify(() => sharedPrefs.saveToken(any())).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(sharedPrefs);
  });
  tearDown(() {
    reset(repository);
    reset(sharedPrefs);
  });
}
