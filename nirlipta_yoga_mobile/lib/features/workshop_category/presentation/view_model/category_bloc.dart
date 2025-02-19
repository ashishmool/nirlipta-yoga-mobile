import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/use_case/create_category_usecase.dart';
import '../../domain/use_case/delete_category_usecase.dart';
import '../../domain/use_case/get_all_categories_usecase.dart';
import '../../domain/use_case/update_category_usecase.dart';
import 'category_state.dart';

part 'category_event.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CreateCategoryUseCase _createCategoryUseCase;
  final GetAllCategoriesUseCase _getAllCategoriesUseCase;
  final DeleteCategoryUseCase _deleteCategoryUseCase;
  final UpdateCategoryUseCase _updateCategoryUseCase;

  CategoryBloc({
    required CreateCategoryUseCase createCategoryUseCase,
    required GetAllCategoriesUseCase getAllCategoriesUseCase,
    required DeleteCategoryUseCase deleteCategoryUseCase,
    required UpdateCategoryUseCase updateCategoryUseCase,
  })  : _createCategoryUseCase = createCategoryUseCase,
        _getAllCategoriesUseCase = getAllCategoriesUseCase,
        _deleteCategoryUseCase = deleteCategoryUseCase,
        _updateCategoryUseCase = updateCategoryUseCase,
        super(CategoryState.initial()) {
    on<LoadCategories>(_onLoadCategories);
    on<AddCategory>(_onAddCategory);
    on<DeleteCategory>(_onDeleteCategory);
    on<UpdateCategory>(_onUpdateCategory);

    // Need to comment before running the Bloc Test
    // Trigger initial loading
    add(LoadCategories());
  }

  Future<void> _onLoadCategories(
      LoadCategories event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllCategoriesUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (categories) => emit(state.copyWith(
        isLoading: false,
        error: null,
        categories: categories,
      )),
    );
  }

  Future<void> _onAddCategory(
      AddCategory event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createCategoryUseCase.call(
      CreateCategoryParams(
          name: event.name,
          description: event.description,
          photo: state.imageName),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => add(LoadCategories()),
    );
  }

  Future<void> _onDeleteCategory(
      DeleteCategory event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteCategoryUseCase.call(
      DeleteCategoryParams(id: event.id),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => add(LoadCategories()),
    );
  }

  Future<void> _onUpdateCategory(
      UpdateCategory event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _updateCategoryUseCase.call(
      UpdateCategoryParams(
          name: event.name, description: event.description, photo: event.photo),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => add(LoadCategories()), // Reload categories after editing
    );
  }
}
