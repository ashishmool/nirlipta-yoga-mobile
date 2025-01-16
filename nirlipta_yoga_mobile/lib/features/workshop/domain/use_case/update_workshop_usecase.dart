import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

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

  UpdateWorkshopUseCase({required this.workshopRepository});

  @override
  Future<Either<Failure, void>> call(UpdateWorkshopParams params) async {
    return workshopRepository.updateWorkshop(params.workshop);
  }
}
