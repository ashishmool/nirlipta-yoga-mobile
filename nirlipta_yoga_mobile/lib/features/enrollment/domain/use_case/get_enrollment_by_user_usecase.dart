import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/enrollment_entity.dart';
import '../repository/enrollment_repository.dart';

class GetEnrollmentByUserParams {
  final String userId;

  const GetEnrollmentByUserParams({required this.userId});
}

class GetEnrollmentByUserUseCase
    implements
        UsecaseWithParams<List<EnrollmentEntity>, GetEnrollmentByUserParams> {
  final IEnrollmentRepository enrollmentRepository;

  GetEnrollmentByUserUseCase({required this.enrollmentRepository});

  @override
  Future<Either<Failure, List<EnrollmentEntity>>> call(
      GetEnrollmentByUserParams params) async {
    return enrollmentRepository.getEnrollmentByUser(params.userId);
  }
}
