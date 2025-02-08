import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/enrollment_entity.dart';
import '../repository/enrollment_repository.dart';

class GetEnrollmentByIdParams extends Equatable {
  final String id;

  const GetEnrollmentByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetEnrollmentByIdUseCase
    implements UsecaseWithParams<EnrollmentEntity, GetEnrollmentByIdParams> {
  final IEnrollmentRepository enrollmentRepository;

  GetEnrollmentByIdUseCase({required this.enrollmentRepository});

  @override
  Future<Either<Failure, EnrollmentEntity>> call(
      GetEnrollmentByIdParams params) async {
    return enrollmentRepository.getEnrollmentById(params.id);
  }
}
