import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/retreat_entity.dart';
import '../../domain/repository/retreat_repository.dart';

class GetRetreatsUseCase {
  final IRetreatRepository repository;

  GetRetreatsUseCase(this.repository);

  Future<Either<Failure, List<RetreatEntity>>> call() async {
    return await repository.getAllRetreats();
  }
}

class AddRetreatUseCase {
  final IRetreatRepository repository;

  AddRetreatUseCase(this.repository);

  Future<Either<Failure, void>> call(RetreatEntity retreatEntity) async {
    return await repository.createRetreat(retreatEntity);
  }
}

class UpdateRetreatUseCase {
  final IRetreatRepository repository;

  UpdateRetreatUseCase(this.repository);

  Future<Either<Failure, void>> call(
      String retreatId, RetreatEntity retreatEntity) async {
    return await repository.updateRetreat(retreatId, retreatEntity);
  }
}

class DeleteRetreatUseCase {
  final IRetreatRepository repository;

  DeleteRetreatUseCase(this.repository);

  Future<Either<Failure, void>> call(String retreatId) async {
    return await repository.deleteRetreat(retreatId);
  }
}
