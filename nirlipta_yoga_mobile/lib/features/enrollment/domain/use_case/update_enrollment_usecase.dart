import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nirlipta_yoga_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/domain/entity/workshop_entity.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/enrollment_entity.dart';
import '../repository/enrollment_repository.dart';

class UpdateEnrollmentParams extends Equatable {
  final String id;
  final String userId;
  final WorkshopEntity workshop;

  // final String workshopId;
  final String paymentStatus;
  final DateTime enrollmentDate;
  final String completionStatus;
  final String? feedback;

  UpdateEnrollmentParams({
    required this.id,
    required this.userId,
    required this.workshop,
    // required this.workshopId,
    this.paymentStatus = "pending",
    DateTime? enrollmentDate,
    this.completionStatus = "not started",
    this.feedback,
  }) : enrollmentDate = enrollmentDate ?? DateTime.now(); // Default dynamically

  factory UpdateEnrollmentParams.empty() {
    return UpdateEnrollmentParams(
      id: '_empty.id',
      userId: '_empty.userId',
      workshop: WorkshopEntity.empty(),
      paymentStatus: "pending",
      enrollmentDate: DateTime(1970, 1, 1),
      // Unix Epoch start
      completionStatus: "not started",
      feedback: null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        workshop,
        paymentStatus,
        enrollmentDate,
        completionStatus,
        feedback,
      ];
}

class UpdateEnrollmentUseCase
    implements UsecaseWithParams<void, UpdateEnrollmentParams> {
  final IEnrollmentRepository enrollmentRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  UpdateEnrollmentUseCase({
    required this.enrollmentRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(UpdateEnrollmentParams params) async {
    final tokenResult = await tokenSharedPrefs.getToken();

    // Handle token retrieval failure
    return tokenResult.fold(
      (failure) => Left(failure),
      (token) async => await enrollmentRepository.updateEnrollment(
        EnrollmentEntity(
          id: params.id,
          userId: params.userId,
          workshop: params.workshop,
          paymentStatus: params.paymentStatus,
          enrollmentDate: params.enrollmentDate,
          completionStatus: params.completionStatus,
          feedback: params.feedback,
        ),
        token, // Pass token here
      ),
    );
  }
}
