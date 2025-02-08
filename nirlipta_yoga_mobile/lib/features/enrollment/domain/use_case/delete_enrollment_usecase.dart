import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nirlipta_yoga_mobile/app/shared_prefs/token_shared_prefs.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/enrollment_repository.dart';

class DeleteEnrollmentParams extends Equatable {
  final String id;

  const DeleteEnrollmentParams({required this.id});

  // Empty Constructor with default values
  factory DeleteEnrollmentParams.empty() {
    return const DeleteEnrollmentParams(id: '_empty.id');
  }

  @override
  List<Object?> get props => [id];
}

class DeleteEnrollmentUseCase
    implements UsecaseWithParams<void, DeleteEnrollmentParams> {
  final IEnrollmentRepository enrollmentRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeleteEnrollmentUseCase({
    required this.enrollmentRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(DeleteEnrollmentParams params) async {
    // Get token from Shared Preferences
    final tokenResult = await tokenSharedPrefs.getToken();

    // Handle token retrieval failure
    return tokenResult.fold(
      (failure) => Left(failure), // Return failure immediately
      (token) async =>
          await enrollmentRepository.deleteEnrollment(params.id, token),
    );
  }
}
