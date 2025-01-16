import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

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

  DeleteWorkshopUseCase({required this.workshopRepository});

  @override
  Future<Either<Failure, void>> call(DeleteWorkshopParams params) async {
    return workshopRepository.deleteWorkshop(params.workshopId);
  }
}
