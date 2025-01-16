import 'package:dartz/dartz.dart';
import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/batch_entity.dart';
import '../repository/batch_repository.dart';


class GetAllBatchUseCase implements UsecaseWithoutParams<List<BatchEntity>>{
  final IBatchRepository batchRepository;

  GetAllBatchUseCase({required this.batchRepository});

  @override
  Future<Either<Failure, List<BatchEntity>>> call() {
    return batchRepository.getAllBatches();
  }


}