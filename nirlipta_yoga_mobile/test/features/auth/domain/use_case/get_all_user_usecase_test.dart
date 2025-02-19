import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/core/error/failure.dart';
import 'package:nirlipta_yoga_mobile/features/auth/domain/entity/user_entity.dart';
import 'package:nirlipta_yoga_mobile/features/auth/domain/use_case/get_all_user_usecase.dart';

import '../../../workshop_category/domain/use_case/token.mock.dart';
import 'auth_repo.mock.dart';

void main() {
  late AuthRepoMock repository;
  late MockTokenSharedPrefs sharedPrefs;
  late GetAllUserUsecase usecase;

  setUp(() {
    repository = AuthRepoMock();
    sharedPrefs = MockTokenSharedPrefs();
    usecase = GetAllUserUsecase(
      userRepository: repository,
      tokenSharedPrefs: sharedPrefs,
    );

    registerFallbackValue(const GetAllUserParams(token: ''));
  });

  final tUser1 = UserEntity(
    id: '1',
    name: 'Test User 1',
    photo: 'IMG-1738569233151.jpg',
    username: 'test user 1',
    phone: '9813943777',
    email: 'testuser1@email.com',
    password: 'test@12345',
    medical_conditions: null,
    gender: 'male',
  );

  final tUser2 = UserEntity(
    id: '2',
    name: 'Test User 2',
    photo: 'IMG-1738569233152.jpg',
    username: 'test user 2',
    phone: '9813943776',
    email: 'testuser2@email.com',
    password: 'test@123456',
    medical_conditions: ['Diabetes'],
    gender: 'female',
  );

  final List<UserEntity> tUsers = [tUser1, tUser2];
  final token = 'valid_token';

  group('GetAllUserUsecase Tests', () {
    test('should call repository.getAllUsers with provided token', () async {
      // Arrange
      when(() => repository.getAllUsers(token)).thenAnswer(
        (_) async => Right<Failure, List<UserEntity>>(tUsers),
      );

      // Act
      final result =
          await usecase(const GetAllUserParams(token: "valid_token"));

      // Assert
      expect(result, Right<Failure, List<UserEntity>>(tUsers));
      verify(() => repository.getAllUsers(token)).called(1);
      verifyNever(() => sharedPrefs.getToken());
    });

    test('should fetch token from sharedPrefs if no token is provided',
        () async {
      // Arrange
      when(() => sharedPrefs.getToken()).thenAnswer(
        (_) async => Right<Failure, String>(token),
      );
      when(() => repository.getAllUsers(token)).thenAnswer(
        (_) async => Right<Failure, List<UserEntity>>(tUsers),
      );

      // Act
      final result = await usecase(const GetAllUserParams.empty());

      // Assert
      expect(result, Right<Failure, List<UserEntity>>(tUsers));
      verify(() => sharedPrefs.getToken()).called(1);
      verify(() => repository.getAllUsers(token)).called(1);
    });

    test('should return failure if token is not available', () async {
      // Arrange
      when(() => sharedPrefs.getToken()).thenAnswer(
        (_) async =>
            Left<Failure, String>(ApiFailure(message: "Token not found")),
      );

      // Act
      final result = await usecase(const GetAllUserParams.empty());

      // Assert
      expect(
        result,
        isA<Left<Failure, List<UserEntity>>>().having(
            (left) => (left as Left).value,
            'failure',
            isA<ApiFailure>()
                .having((f) => f.message, 'message', "Token not found")),
      );
      verify(() => sharedPrefs.getToken()).called(1);
      verifyNever(() => repository.getAllUsers(any()));
    });

    test('should return failure if repository.getAllUsers fails', () async {
      // Arrange
      when(() => repository.getAllUsers(token)).thenAnswer(
        (_) async => Left<Failure, List<UserEntity>>(
            ApiFailure(message: "Server error")),
      );

      // Act
      final result =
          await usecase(const GetAllUserParams(token: "valid_token"));

      // Assert
      expect(
        result,
        isA<Left<Failure, List<UserEntity>>>().having(
            (left) => (left as Left).value,
            'failure',
            isA<ApiFailure>()
                .having((f) => f.message, 'message', "Server error")),
      );
      verify(() => repository.getAllUsers(token)).called(1);
      verifyNever(() => sharedPrefs.getToken());
    });
  });
}
