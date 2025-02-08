import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/enrollment_entity.dart';
import '../repository/enrollment_repository.dart';

class CreateEnrollmentParams extends Equatable {
  final String userId;
  final String workshopId;
  final String paymentStatus;
  final DateTime enrollmentDate;
  final String completionStatus;
  final String? feedback;

  CreateEnrollmentParams({
    required this.userId,
    required this.workshopId,
    this.paymentStatus = "pending",
    DateTime? enrollmentDate,
    this.completionStatus = "not started",
    this.feedback,
  }) : enrollmentDate = enrollmentDate ?? DateTime.now(); // Default dynamically

  factory CreateEnrollmentParams.empty() {
    return CreateEnrollmentParams(
      userId: '_empty.userId',
      workshopId: '_empty.workshopId',
      paymentStatus: "pending",
      enrollmentDate: DateTime(1970, 1, 1),
      // Unix Epoch start
      completionStatus: "not started",
      feedback: null,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        workshopId,
        paymentStatus,
        enrollmentDate,
        completionStatus,
        feedback,
      ];
}

class CreateEnrollmentUseCase
    implements UsecaseWithParams<void, CreateEnrollmentParams> {
  final IEnrollmentRepository enrollmentRepository;

  CreateEnrollmentUseCase({required this.enrollmentRepository});

  @override
  Future<Either<Failure, void>> call(CreateEnrollmentParams params) async {
    return await enrollmentRepository.createEnrollment(
      EnrollmentEntity(
        userId: params.userId,
        workshopId: params.workshopId,
        paymentStatus: params.paymentStatus,
        enrollmentDate: params.enrollmentDate,
        completionStatus: params.completionStatus,
        feedback: params.feedback,
      ),
    );
  }
}
