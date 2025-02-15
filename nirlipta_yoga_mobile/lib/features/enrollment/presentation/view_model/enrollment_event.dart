part of 'enrollment_bloc.dart';

@immutable
sealed class EnrollmentEvent extends Equatable {
  const EnrollmentEvent();

  @override
  List<Object?> get props => [];
}

// Load all enrollments
final class LoadEnrollments extends EnrollmentEvent {}

// Load enrollments by user
final class LoadEnrollmentByUser extends EnrollmentEvent {
  final String userId;

  const LoadEnrollmentByUser({required this.userId});

  @override
  List<Object?> get props => [userId];
}

// Add a new enrollment
final class AddEnrollment extends EnrollmentEvent {
  final String userId;

  // final String workshopId;
  final WorkshopEntity workshop;

  // final WorkshopEntity workshopId;
  final String paymentStatus;
  final DateTime enrollmentDate;
  final String completionStatus;
  final String? feedback;

  const AddEnrollment(
      {required this.userId,
      required this.workshop,
      required this.paymentStatus,
      required this.enrollmentDate,
      required this.completionStatus,
      this.feedback});

  @override
  List<Object?> get props => [
        userId,
        workshop,
        paymentStatus,
        enrollmentDate,
        completionStatus,
        feedback
      ];
}

// Update an existing enrollment
final class UpdateEnrollment extends EnrollmentEvent {
  final String? id;
  final String userId;

  // final String workshopId;
  final WorkshopEntity workshop;
  final String paymentStatus;
  final DateTime enrollmentDate;
  final String completionStatus;
  final String? feedback;

  const UpdateEnrollment(
      {required this.id,
      required this.userId,
      required this.workshop,
      required this.paymentStatus,
      required this.enrollmentDate,
      required this.completionStatus,
      this.feedback});

  @override
  List<Object?> get props => [
        id,
        userId,
        workshop,
        paymentStatus,
        enrollmentDate,
        completionStatus,
        feedback
      ];
}

// Delete an enrollment using its id
final class DeleteEnrollment extends EnrollmentEvent {
  final String id;

  const DeleteEnrollment(this.id);

  @override
  List<Object?> get props => [id];
}
