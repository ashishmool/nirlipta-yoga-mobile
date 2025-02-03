part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

final class LoadCategories extends CategoryEvent {}

final class AddCategory extends CategoryEvent {
  final String name;
  final String? description;
  final String? photo;

  const AddCategory(
      {required this.name, required this.description, required this.photo});

  @override
  List<Object?> get props => [name, description, photo];
}

final class DeleteCategory extends CategoryEvent {
  final String categoryId;

  const DeleteCategory({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}

final class UpdateCategory extends CategoryEvent {
  final String categoryId;
  final String name;
  final String? description;
  final String? photo;

  const UpdateCategory({
    required this.categoryId,
    required this.name,
    this.description,
    this.photo,
  });

  @override
  List<Object?> get props => [categoryId, name, description, photo];
}
