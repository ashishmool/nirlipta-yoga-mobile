import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/core/error/failure.dart';
import 'package:nirlipta_yoga_mobile/features/auth/domain/use_case/login_user_usecase.dart';

import '../../../workshop_category/domain/use_case/token.mock.dart';
import 'auth_repo.mock.dart';

void main() {
  late AuthRepoMock repository;
  late MockUserSharedPrefs userSharedPrefs;
  late LoginUserUsecase usecase;

  setUp(() {
    repository = AuthRepoMock();
    userSharedPrefs = MockUserSharedPrefs();
    usecase = LoginUserUsecase(
      userRepository: repository,
      userSharedPrefs: userSharedPrefs,
    );
  });

  test(
      'should call the [AuthRepo.login] with correct email and password (a3.asis@gmail.com, test12345)',
      () async {
    when(() => repository.login(any(), any())).thenAnswer(
      (invocation) async {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        if (email == 'a3.asis@gmail.com' && password == 'test12345') {
          return Future.value(const Right([
            'success',
            'token',
            'userID',
            'photo',
            'email',
            'role',
            'message',
            '200'
          ]));
        } else {
          return Future.value(
              Left(ApiFailure(message: 'Invalid email or password')));
        }
      },
    );

    when(() => userSharedPrefs.setUserData(any())).thenAnswer(
      (_) async => const Right(true),
    );

    final result = await usecase(
      LoginUserParams(email: 'a3.asis@gmail.com', password: 'test12345'),
    );

    expect(
      result,
      const Right([
        'success',
        'token',
        'userID',
        'photo',
        'email',
        'role',
        'message',
        '200'
      ]),
    );

    verify(() => repository.login(any(), any())).called(1);
    verify(() => userSharedPrefs.setUserData(any())).called(1); // ✅ Fix

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(userSharedPrefs); // ✅ Fix
  });

  tearDown(() {
    reset(repository);
    reset(userSharedPrefs); // ✅ Fix
  });
}
