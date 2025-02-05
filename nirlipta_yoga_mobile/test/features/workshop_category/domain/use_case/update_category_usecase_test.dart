import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/core/error/failure.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/domain/entity/category_entity.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/domain/use_case/update_category_usecase.dart';

import 'repository.mock.dart';
import 'token.mock.dart';

void main() {
  late MockCategoryRepository repository;
  late MockTokenSharedPrefs sharedPrefs;
  late UpdateCategoryUseCase usecase;

  setUp(() {
    repository = MockCategoryRepository();
    sharedPrefs = MockTokenSharedPrefs();
    usecase = UpdateCategoryUseCase(
      categoryRepository: repository,
      tokenSharedPrefs: sharedPrefs,
    );

    registerFallbackValue(CategoryEntity(
      id: null,
      name: 'Fallback',
      description: 'Fallback description',
      photo: 'fallback_photo.jpg',
    ));
  });

  final tParams = UpdateCategoryParams(
    id: '1',
    name: 'Updated Category',
    description: 'Updated Description',
    photo: 'updated_photo.jpg',
  );

  final tCategoryEntity = CategoryEntity(
    id: null,
    name: tParams.name,
    description: tParams.description,
    photo: tParams.photo,
  );

  final token = 'token';

  test('should update category successfully', () async {
    // Arrange
    when(() => sharedPrefs.getToken()).thenAnswer((_) async => Right(token));

    when(() => repository.updateCategory(any(), any()))
        .thenAnswer((_) async => Right(null));

    // Act
    final result = await usecase(tParams);

    // Assert
    expect(result, Right(null));

    // Verify
    verify(() => sharedPrefs.getToken()).called(1);
    verify(() => repository.updateCategory(tCategoryEntity, token)).called(1);
    verifyNoMoreInteractions(sharedPrefs);
    verifyNoMoreInteractions(repository);
  });

  test('should return failure when repository fails', () async {
    // Arrange
    when(() => sharedPrefs.getToken()).thenAnswer((_) async => Right(token));

    when(() => repository.updateCategory(any(), any()))
        .thenAnswer((_) async => Left(ApiFailure(message: 'Update failed')));

    // Act
    final result = await usecase(tParams);

    // Assert
    expect(result.fold((l) => l.message, (r) => null), 'Update failed');

    // Verify
    verify(() => sharedPrefs.getToken()).called(1);
    verify(() => repository.updateCategory(tCategoryEntity, token)).called(1);
    verifyNoMoreInteractions(sharedPrefs);
    verifyNoMoreInteractions(repository);
  });

  test('should return failure when token retrieval fails', () async {
    // Arrange
    when(() => sharedPrefs.getToken())
        .thenAnswer((_) async => Left(ApiFailure(message: 'No token found')));

    // Act
    final result = await usecase(tParams);

    // Assert
    expect(result.fold((l) => l.message, (r) => null), 'No token found');

    // Verify
    verify(() => sharedPrefs.getToken()).called(1);
    verifyNoMoreInteractions(sharedPrefs);
    verifyNoMoreInteractions(repository);
  });
}
