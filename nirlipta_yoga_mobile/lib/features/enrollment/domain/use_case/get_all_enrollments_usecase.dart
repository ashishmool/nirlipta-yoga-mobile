import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/enrollment_entity.dart';
import '../repository/enrollment_repository.dart';

class GetAllEnrollmentsUseCase
    implements UsecaseWithoutParams<List<EnrollmentEntity>> {
  final IEnrollmentRepository enrollmentRepository;

  GetAllEnrollmentsUseCase({required this.enrollmentRepository});

  @override
  // Future<Either<Failure, List<EnrollmentEntity>>> call() {
  //   return enrollmentRepository.getAllEnrollments();
  // }
  Future<Either<Failure, List<EnrollmentEntity>>> call() async {
    final response = await enrollmentRepository.getAllEnrollments();
    print("Repository response: $response");
    return response;
  }

}
