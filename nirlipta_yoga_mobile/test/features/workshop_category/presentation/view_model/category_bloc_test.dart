import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/core/error/failure.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/domain/entity/category_entity.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/domain/use_case/create_category_usecase.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/domain/use_case/delete_category_usecase.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/domain/use_case/get_all_categories_usecase.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/domain/use_case/update_category_usecase.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/presentation/view_model/category_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/workshop_category/presentation/view_model/category_state.dart';

class MockCreateCategoryUseCase extends Mock implements CreateCategoryUseCase {}

class MockGetAllCategoriesUseCase extends Mock
    implements GetAllCategoriesUseCase {}

class MockDeleteCategoryUseCase extends Mock implements DeleteCategoryUseCase {}

class MockUpdateCategoryUseCase extends Mock implements UpdateCategoryUseCase {}

void main() {
  late MockCreateCategoryUseCase createCategoryUseCase;
  late MockGetAllCategoriesUseCase getAllCategoriesUseCase;
  late MockDeleteCategoryUseCase deleteCategoryUseCase;
  late MockUpdateCategoryUseCase updateCategoryUseCase;
  late CategoryBloc categoryBloc;

  setUp(() {
    createCategoryUseCase = MockCreateCategoryUseCase();
    getAllCategoriesUseCase = MockGetAllCategoriesUseCase();
    deleteCategoryUseCase = MockDeleteCategoryUseCase();
    updateCategoryUseCase = MockUpdateCategoryUseCase();

    categoryBloc = CategoryBloc(
      createCategoryUseCase: createCategoryUseCase,
      getAllCategoriesUseCase: getAllCategoriesUseCase,
      deleteCategoryUseCase: deleteCategoryUseCase,
      updateCategoryUseCase: updateCategoryUseCase,
    );
  });

  tearDown(() {
    categoryBloc.close();
  });

  group('Category Bloc', () {
    final category1 = CategoryEntity(id: '1', name: 'Category 1');
    final category2 = CategoryEntity(id: '2', name: 'Category 2');
    final lstCategories = [category1, category2];

    blocTest<CategoryBloc, CategoryState>(
      'emits [CategoryState] when LoadCategories is added',
      build: () {
        when(() => getAllCategoriesUseCase.call())
            .thenAnswer((_) async => Right(lstCategories));
        return categoryBloc;
      },
      act: (bloc) => bloc.add(LoadCategories()),
      expect: () => [
        CategoryState.initial().copyWith(isLoading: true),
        CategoryState.initial()
            .copyWith(isLoading: false, categories: lstCategories),
      ],
      verify: (_) {
        verify(() => getAllCategoriesUseCase.call()).called(1);
      },
    );
    blocTest<CategoryBloc, CategoryState>(
      'emits [CategoryState] with loaded categories is added with skip 1',
      build: () {
        when(() => getAllCategoriesUseCase.call())
            .thenAnswer((_) async => Right(lstCategories));
        return categoryBloc;
      },
      act: (bloc) => bloc.add(LoadCategories()),
      skip: 1,
      expect: () => [
        CategoryState.initial()
            .copyWith(isLoading: false, categories: lstCategories),
      ],
      verify: (_) {
        verify(() => getAllCategoriesUseCase.call()).called(1);
      },
    );

    blocTest<CategoryBloc, CategoryState>(
      'emits [CategoryState] with error when LoadCategories fails',
      build: () {
        when(() => getAllCategoriesUseCase.call())
            .thenAnswer((_) async => Left(ApiFailure(message: 'Error')));
        return categoryBloc;
      },
      act: (bloc) => bloc.add(LoadCategories()),
      expect: () => [
        CategoryState.initial().copyWith(isLoading: true),
        CategoryState.initial().copyWith(isLoading: false, error: 'Error'),
      ],
      verify: (_) {
        verify(() => getAllCategoriesUseCase.call()).called(1);
      },
    );
  });
}
