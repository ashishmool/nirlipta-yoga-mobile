import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/category_entity.dart';

abstract interface class ICategoryRepository {
  Future<Either<Failure, void>> createCategory(CategoryEntity categoryEntity);

  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();

  Future<Either<Failure, CategoryEntity>> getCategoryById(String id);

  Future<Either<Failure, void>> updateCategory(
      CategoryEntity categoryEntity, String? token);

  Future<Either<Failure, void>> deleteCategory(String id, String? token);
}
