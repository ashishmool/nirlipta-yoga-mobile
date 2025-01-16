import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/batch_entity.dart';
import '../repository/batch_repository.dart';

class CreateBatchParams extends Equatable {
  final String batchName;

  const CreateBatchParams({required this.batchName});

  //Empty Constructor
  const CreateBatchParams.empty() : batchName = '_empty.string';

  @override
  List<Object?> get props => [batchName];
}

class CreateBatchUseCase implements UsecaseWithParams<void, CreateBatchParams> {
  final IBatchRepository batchRepository;

  CreateBatchUseCase({required this.batchRepository});

  @override
  Future<Either<Failure, void>> call(CreateBatchParams params) async {
    return await batchRepository.createBatch(
      BatchEntity(
        batchName: params.batchName,
      ),
    );
  }
}
