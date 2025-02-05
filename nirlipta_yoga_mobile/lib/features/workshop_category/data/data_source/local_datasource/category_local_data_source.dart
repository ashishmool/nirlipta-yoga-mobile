import '../../../../../core/network/hive_service.dart';
import '../../../domain/entity/category_entity.dart';
import '../../model/category_hive_model.dart';
import '../category_data_source.dart';

class CategoryLocalDataSource implements ICategoryDataSource {
  final HiveService _hiveService;

  CategoryLocalDataSource(this._hiveService);

  @override
  Future<void> createCategory(CategoryEntity categoryEntity) async {
    try {
      final categoryHiveModel = CategoryHiveModel.fromEntity(categoryEntity);
      await _hiveService.addCategory(categoryHiveModel);
    } catch (e) {
      throw Exception('Error creating category: $e');
    }
  }

  @override
  Future<void> deleteCategory(String id, String? token) async {
    try {
      await _hiveService.deleteCategory(id);
    } catch (e) {
      throw Exception('Error deleting category: $e');
    }
  }

  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    try {
      final categories = await _hiveService.getAllCategories();
      return categories.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Error fetching all categories: $e');
    }
  }

  @override
  Future<CategoryEntity> getCategoryById(String id) async {
    try {
      final categoryHiveModel = await _hiveService.getCategoryById(id);
      if (categoryHiveModel != null) {
        return categoryHiveModel.toEntity();
      } else {
        throw Exception('Category not found');
      }
    } catch (e) {
      throw Exception('Error fetching category by ID: $e');
    }
  }

  @override
  Future<void> updateCategory(CategoryEntity categoryEntity) async {
    try {
      final categoryHiveModel = CategoryHiveModel.fromEntity(categoryEntity);
      await _hiveService.updateCategory(categoryHiveModel);
    } catch (e) {
      throw Exception('Error updating category: $e');
    }
  }
}
