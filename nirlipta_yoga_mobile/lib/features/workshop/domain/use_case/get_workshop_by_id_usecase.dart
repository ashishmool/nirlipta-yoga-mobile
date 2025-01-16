import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/workshop_entity.dart';
import '../repository/workshop_repository.dart';

class GetWorkshopByIdParams extends Equatable {
  final String workshopId;

  const GetWorkshopByIdParams({required this.workshopId});

  @override
  List<Object?> get props => [workshopId];
}

class GetWorkshopByIdUseCase
    implements UsecaseWithParams<WorkshopEntity, GetWorkshopByIdParams> {
  final IWorkshopRepository workshopRepository;

  GetWorkshopByIdUseCase({required this.workshopRepository});

  @override
  Future<Either<Failure, WorkshopEntity>> call(
      GetWorkshopByIdParams params) async {
    return workshopRepository.getWorkshopById(params.workshopId);
  }
}
