import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/shared_prefs/token_shared_prefs.dart';
import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/category_entity.dart';
import '../repository/category_repository.dart';

class UpdateCategoryParams extends Equatable {
  final String? id;
  final String name;
  final String? description;
  final String? photo;

  const UpdateCategoryParams({
    this.id,
    required this.name,
    this.description,
    this.photo,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        photo,
      ];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'photo': photo,
    };
  }
}

class UpdateCategoryUseCase
    implements UsecaseWithParams<void, UpdateCategoryParams> {
  final ICategoryRepository categoryRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  const UpdateCategoryUseCase(
      {required this.categoryRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, void>> call(UpdateCategoryParams params) async {
    final categoryEntity = CategoryEntity(
      id: null,
      name: params.name,
      description: params.description,
      photo: params.photo,
    );

    // Get token from Shared Preferences and send it to server
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return await categoryRepository.updateCategory(categoryEntity, r);
    });

    // return await categoryRepository.updateCategory(categoryEntity);
  }
}
