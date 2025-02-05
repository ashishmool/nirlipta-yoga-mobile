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
  final String id;

  const DeleteCategory({required this.id});

  @override
  List<Object?> get props => [id];
}

final class UpdateCategory extends CategoryEvent {
  final String id;
  final String name;
  final String? description;
  final String? photo;

  const UpdateCategory({
    required this.id,
    required this.name,
    this.description,
    this.photo,
  });

  @override
  List<Object?> get props => [id, name, description, photo];
}
