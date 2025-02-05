import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/core/error/failure.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/domain/use_case/delete_category_usecase.dart';

import 'repository.mock.dart';
import 'token.mock.dart';

void main() {
  // Initialization will happen later so no constructor required
  late MockCategoryRepository repository;
  late MockTokenSharedPrefs sharedPrefs;
  late DeleteCategoryUseCase usecase;

  // Creating Setup for Mocking Repository
  setUp(() {
    repository = MockCategoryRepository();
    sharedPrefs = MockTokenSharedPrefs();
    usecase = DeleteCategoryUseCase(
        categoryRepository: repository, tokenSharedPrefs: sharedPrefs);
  });

  final tCategoryId = 'category1';
  final token = 'token';
  final deleteCategoryParams = DeleteCategoryParams(id: tCategoryId);

  // final params = DeleteCategoryParams.empty(); // Not Required since there is no usage

  test('delete category using id', () async {
    //Arrange (First Step)
    when(() => sharedPrefs.getToken()).thenAnswer(
      (_) async => Right(token),
    );

    when(() => repository.deleteCategory(any(), any())).thenAnswer(
      (_) async => Right(null),
    );

    // Act
    final result = await usecase(deleteCategoryParams);
    // final result = Failure;

    // Assert
    expect(result, Right(null));

    // Verify
    verify(() => sharedPrefs.getToken()).called(1);
    verify(() => repository.deleteCategory(tCategoryId, token)).called(1);

    verifyNoMoreInteractions(sharedPrefs);
    verifyNoMoreInteractions(repository);
  });

  test('delete category using id and check whether the id is category1',
      () async {
    //Arrange
    when(() => sharedPrefs.getToken()).thenAnswer(
      (_) async => Right(token),
    );

    when(() => repository.deleteCategory(any(), any())).thenAnswer(
      (invocation) async {
        final id = invocation.positionalArguments[0] as String;

        if (id == 'category1') {
          return Right(null);
        } else {
          return Left(ApiFailure(
            message: 'Category ID not found!',
          ));
        }
      },
    );

    // Act
    final result = await usecase(deleteCategoryParams);
    // final result = Failure;

    // Assert
    expect(result, Right(null));

    // Verify
    verify(() => sharedPrefs.getToken()).called(1);
    verify(() => repository.deleteCategory(tCategoryId, token)).called(1);

    verifyNoMoreInteractions(sharedPrefs);
    verifyNoMoreInteractions(repository);
  });
}
