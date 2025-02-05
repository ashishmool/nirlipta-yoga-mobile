import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/core/error/failure.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/domain/entity/category_entity.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/domain/use_case/get_category_by_id_usecase.dart';

import 'repository.mock.dart';

void main() {
  late MockCategoryRepository repository;
  late GetCategoryByIdUseCase usecase;

  setUp(() {
    repository = MockCategoryRepository();
    usecase = GetCategoryByIdUseCase(categoryRepository: repository);
  });

  final tCategory = CategoryEntity(
    id: '1',
    name: 'Test Category',
    description: 'Test Description for Category',
    photo: 'IMG-1738569233151.jpg',
  );

  final tCategoryId = '1';

  test('should call the [CategoryRepo.getCategoryById] with the correct id',
      () async {
    when(() => repository.getCategoryById(tCategoryId)).thenAnswer(
      (_) async => Right(tCategory),
    );

    // Act
    final result = await usecase(GetCategoryByIdParams(id: tCategoryId));

    // Assert
    expect(result, Right(tCategory));

    // Verify
    verify(() => repository.getCategoryById(tCategoryId)).called(1);

    verifyNoMoreInteractions(repository);
  });

  test(
      'should return a failure when the repository fails to get category by id',
      () async {
    final tFailure = ApiFailure(message: 'API Failure');
    when(() => repository.getCategoryById(tCategoryId)).thenAnswer(
      (_) async => Left(tFailure),
    );

    // Act
    final result = await usecase(GetCategoryByIdParams(id: tCategoryId));

    // Assert
    expect(result, Left(tFailure));

    // Verify
    verify(() => repository.getCategoryById(tCategoryId)).called(1);

    verifyNoMoreInteractions(repository);
  });
}
