import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/workshop_entity.dart';
import '../repository/workshop_repository.dart';

class GetAllWorkshopsUseCase
    implements UsecaseWithoutParams<List<WorkshopEntity>> {
  final IWorkshopRepository workshopRepository;

  GetAllWorkshopsUseCase({required this.workshopRepository});

  @override
  Future<Either<Failure, List<WorkshopEntity>>> call() {
    return workshopRepository.getAllWorkshops();
  }
}
