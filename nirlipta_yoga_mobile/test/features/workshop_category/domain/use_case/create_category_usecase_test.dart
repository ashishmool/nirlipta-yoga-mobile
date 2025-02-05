import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/domain/entity/category_entity.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/domain/use_case/create_category_usecase.dart';

import 'repository.mock.dart';

void main() {
  // Initialization will happen later so no constructor required
  late MockCategoryRepository repository;
  late CreateCategoryUseCase usecase;

  // Creating Setup for Mocking Repository
  setUp(() {
    repository = MockCategoryRepository();
    usecase = CreateCategoryUseCase(categoryRepository: repository);
    registerFallbackValue(CategoryEntity.empty());
  });

  final params = CreateCategoryParams.empty();

  test('should call the [CategoryRepo.createCategory]', () async {
    when(() => repository.createCategory(any())).thenAnswer(
      (_) async => Right(null),
    );

    // Act
    final result = await usecase(params);
    // final result = Failure;

    // Assert
    expect(result, Right(null));

    // Verify
    verify(() => repository.createCategory(any())).called(1);

    verifyNoMoreInteractions(repository);
  });
}
