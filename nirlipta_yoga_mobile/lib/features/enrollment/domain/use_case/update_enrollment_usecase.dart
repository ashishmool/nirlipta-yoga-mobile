import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nirlipta_yoga_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/domain/entity/workshop_entity.dart';

import '../../../../app/shared_prefs/user_shared_prefs.dart';
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
    this.paymentStatus = "paid",
    DateTime? enrollmentDate,
    this.completionStatus = "in progress",
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'workshop_id': workshop,
      'payment_status': paymentStatus,
      'enrollment_date': enrollmentDate,
      'completion_status': completionStatus,
      'feedback': feedback,
    };
  }
}

class UpdateEnrollmentUseCase
    implements UsecaseWithParams<void, UpdateEnrollmentParams> {
  final IEnrollmentRepository enrollmentRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final UserSharedPrefs userSharedPrefs;

  UpdateEnrollmentUseCase({
    required this.enrollmentRepository,
    required this.tokenSharedPrefs,
    required this.userSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(UpdateEnrollmentParams params) async {
    // final tokenResult = await tokenSharedPrefs.getToken();
    final userDataResult = await userSharedPrefs.getUserData();

    return userDataResult.fold(
      (failure) => Left(failure),
      // Return failure if fetching user data fails
      (userData) async {
        if (userData[2] == null || userData[1] == null) {
          return Left(
              SharedPrefsFailure(message: "User ID or Token is missing"));
        }

        final String userId = userData[2]!; // Extract userId
        final String token = userData[1]!; // Extract token

        return await enrollmentRepository.updateEnrollment(
          EnrollmentEntity(
            id: params.id,
            userId: params.userId,
            workshop: params.workshop,
            paymentStatus: params.paymentStatus,
            enrollmentDate: params.enrollmentDate,
            completionStatus: params.completionStatus,
            feedback: params.feedback,
          ),
          token,
        );
      },
    );
  }
}
