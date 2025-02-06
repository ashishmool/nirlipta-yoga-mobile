import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/features/auth/domain/entity/user_entity.dart';
import 'package:nirlipta_yoga_mobile/features/auth/domain/use_case/create_user_usecase.dart';

import 'auth_repo.mock.dart';

void main() {
  // Initialization will happen later so no constructor required
  late AuthRepoMock repository;
  late CreateUserUsecase usecase;

  // Creating Setup for Mocking Repository
  setUp(() {
    repository = AuthRepoMock();
    usecase = CreateUserUsecase(userRepository: repository);
    registerFallbackValue(UserEntity.empty());
  });

  final params = CreateUserParams.empty();

  test('should call the [UserRepo.createUser]', () async {
    when(() => repository.createUser(any())).thenAnswer(
      (_) async => Right(null),
    );

    // Act
    final result = await usecase(params);
    // final result = Failure;

    // Assert
    expect(result, Right(null));

    // Verify
    verify(() => repository.createUser(any())).called(1);

    verifyNoMoreInteractions(repository);
  });
}
