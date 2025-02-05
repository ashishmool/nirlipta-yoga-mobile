import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/category_entity.dart';
import '../repository/category_repository.dart';

class CreateCategoryParams extends Equatable {
  final String name;
  final String? description;
  final String? photo;

  const CreateCategoryParams({
    required this.name,
    this.description,
    this.photo,
  });

  // Initialize Empty Constructor
  const CreateCategoryParams.empty()
      : name = '_empty.name',
        description = '_empty.description',
        photo = '_empty.photo';

  @override
  List<Object?> get props => [
        name,
        description,
        photo,
      ];
}

class CreateCategoryUseCase
    implements UsecaseWithParams<void, CreateCategoryParams> {
  final ICategoryRepository categoryRepository;

  CreateCategoryUseCase({required this.categoryRepository});

  @override
  Future<Either<Failure, void>> call(CreateCategoryParams params) async {
    return await categoryRepository.createCategory(
      CategoryEntity(
        name: params.name,
        description: params.description,
        photo: params.photo,
      ),
    );
  }
}
