import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nirlipta_yoga_mobile/app/shared_prefs/token_shared_prefs.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/workshop_repository.dart';

class DeleteWorkshopParams extends Equatable {
  final String workshopId;

  const DeleteWorkshopParams({required this.workshopId});

  @override
  List<Object?> get props => [workshopId];
}

class DeleteWorkshopUseCase
    implements UsecaseWithParams<void, DeleteWorkshopParams> {
  final IWorkshopRepository workshopRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeleteWorkshopUseCase(
      {required this.workshopRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, void>> call(DeleteWorkshopParams params) async {
    // Get token from Shared Preferences and send it to server
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return await workshopRepository.deleteWorkshop(params.workshopId, r);
    });
  }
}
