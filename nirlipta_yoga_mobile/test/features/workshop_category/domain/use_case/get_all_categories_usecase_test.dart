import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/domain/entity/category_entity.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/domain/use_case/get_all_categories_usecase.dart';

import 'repository.mock.dart';

void main() {
  late MockCategoryRepository repository;
  late GetAllCategoriesUseCase usecase;

  setUp(() {
    repository = MockCategoryRepository();
    usecase = GetAllCategoriesUseCase(categoryRepository: repository);
  });

  final tCategory1 = CategoryEntity(
    id: '1',
    name: 'Test Category 1',
    description: 'Test Description for Category 1',
    photo: 'IMG-1738569233151.jpg',
  );

  final tCategory2 = CategoryEntity(
    id: '2',
    name: 'Test Category 2',
    description: 'Test Description for Category 2',
    photo: 'IMG-1738569233151.jpg',
  );
  final tCategories = [tCategory1, tCategory2];

  test('should call the [CategoryRepo.getAllCategories]', () async {
    when(() => repository.getAllCategories()).thenAnswer(
          (_) async => Right(tCategories),
    );

    // Act
    final result = await usecase();
    // final result = Failure;

    // Assert
    expect(result, Right(tCategories));

    // Verify
    verify(() => repository.getAllCategories()).called(1);

    verifyNoMoreInteractions(repository);
  });
}
