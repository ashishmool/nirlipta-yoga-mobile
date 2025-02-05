import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/category_entity.dart';
import '../repository/category_repository.dart';

class GetCategoryByIdParams extends Equatable {
  final String id;

  const GetCategoryByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetCategoryByIdUseCase
    implements UsecaseWithParams<CategoryEntity, GetCategoryByIdParams> {
  final ICategoryRepository categoryRepository;

  GetCategoryByIdUseCase({required this.categoryRepository});

  @override
  Future<Either<Failure, CategoryEntity>> call(
      GetCategoryByIdParams params) async {
    return categoryRepository.getCategoryById(params.id);
  }
}
