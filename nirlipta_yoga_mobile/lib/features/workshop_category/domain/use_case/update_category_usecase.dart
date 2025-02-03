import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../../workshop/data/model/workshop_api_model.dart';
import '../entity/category_entity.dart';
import '../repository/category_repository.dart';

class UpdateCategoryParams extends Equatable {
  final String? id;
  final String name;
  final String? description;
  final String? photo;
  final List<WorkshopApiModel> workshops;

  const UpdateCategoryParams({
    this.id,
    required this.name,
    required this.workshops,
    this.description,
    this.photo,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        photo,
        workshops,
      ];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'photo': photo,
      'workshops': workshops.map((workshop) => workshop.toJson()).toList(),
    };
  }
}

class UpdateCategoryUseCase
    implements UsecaseWithParams<void, UpdateCategoryParams> {
  final ICategoryRepository categoryRepository;

  const UpdateCategoryUseCase({required this.categoryRepository});

  @override
  Future<Either<Failure, void>> call(UpdateCategoryParams params) async {
    final categoryEntity = CategoryEntity(
      id: null,
      name: params.name,
      description: params.description,
      photo: params.photo,
    );

    return await categoryRepository.updateCategory(categoryEntity);
  }
}
