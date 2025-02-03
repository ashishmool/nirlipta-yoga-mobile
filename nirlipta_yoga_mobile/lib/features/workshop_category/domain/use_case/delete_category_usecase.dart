import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nirlipta_yoga_mobile/app/shared_prefs/token_shared_prefs.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/category_repository.dart';

class DeleteCategoryParams extends Equatable {
  final String categoryId;

  const DeleteCategoryParams({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}

class DeleteCategoryUseCase
    implements UsecaseWithParams<void, DeleteCategoryParams> {
  final ICategoryRepository categoryRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeleteCategoryUseCase(
      {required this.categoryRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, void>> call(DeleteCategoryParams params) async {
    // Get token from Shared Preferences and send it to server
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return await categoryRepository.deleteCategory(params.categoryId, r);
    });
  }
}
