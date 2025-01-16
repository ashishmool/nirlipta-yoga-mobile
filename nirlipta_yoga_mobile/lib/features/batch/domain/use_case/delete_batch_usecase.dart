import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/batch_repository.dart';

class DeleteBatchParams extends Equatable{
  final String batchId;

  const DeleteBatchParams({required this.batchId});

  //Empty Constructor
  const DeleteBatchParams.empty() : batchId = '_empty.string';

  @override
  List<Object?> get props => [batchId];
}

class DeleteBatchUseCase implements UsecaseWithParams<void, DeleteBatchParams>{
  final IBatchRepository batchRepository;

  DeleteBatchUseCase({required this.batchRepository});

  @override
  Future<Either<Failure, void>> call(DeleteBatchParams params) async{
    return batchRepository.deleteBatch(params.batchId);
  }
}