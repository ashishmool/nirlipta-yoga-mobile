import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/category_entity.dart';
import '../repository/category_repository.dart';

class GetAllCategoriesUseCase
    implements UsecaseWithoutParams<List<CategoryEntity>> {
  final ICategoryRepository categoryRepository;

  GetAllCategoriesUseCase({required this.categoryRepository});

  @override
  Future<Either<Failure, List<CategoryEntity>>> call() {
    return categoryRepository.getAllCategories();
  }
}
