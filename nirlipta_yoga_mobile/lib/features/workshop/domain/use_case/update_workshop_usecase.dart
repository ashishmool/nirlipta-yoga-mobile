import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/shared_prefs/token_shared_prefs.dart';
import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/workshop_entity.dart';
import '../repository/workshop_repository.dart';

class UpdateWorkshopParams extends Equatable {
  final WorkshopEntity workshop;

  const UpdateWorkshopParams({required this.workshop});

  @override
  List<Object?> get props => [workshop];
}

class UpdateWorkshopUseCase
    implements UsecaseWithParams<void, UpdateWorkshopParams> {
  final IWorkshopRepository workshopRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  UpdateWorkshopUseCase({
    required this.workshopRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(UpdateWorkshopParams params) async {
    // Ensure the workshop has a valid ID for updating
    if (params.workshop.id == null) {
      return Left(ApiFailure(message: 'Workshop ID is required for updating.'));
    }

    // Retrieve token from shared preferences
    final token = await tokenSharedPrefs.getToken();
    return token.fold(
      (l) => Left(l),
      (r) async {
        return await workshopRepository.updateWorkshop(params.workshop, r);
      },
    );
  }
}
