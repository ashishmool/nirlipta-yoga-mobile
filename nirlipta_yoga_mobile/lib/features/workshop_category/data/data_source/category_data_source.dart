import '../../domain/entity/category_entity.dart';

abstract interface class ICategoryDataSource {
  Future<void> createCategory(CategoryEntity categoryEntity);

  Future<List<CategoryEntity>> getAllCategories();

  Future<CategoryEntity> getCategoryById(String id);

  Future<void> updateCategory(CategoryEntity categoryEntity);

  Future<void> deleteCategory(String id, String? token);
}
