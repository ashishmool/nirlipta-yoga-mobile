part of 'enrollment_bloc.dart';

@immutable
sealed class EnrollmentEvent extends Equatable {
  const EnrollmentEvent();

  @override
  List<Object?> get props => [];
}

final class LoadEnrollments extends EnrollmentEvent {}

final class LoadEnrollmentByUser extends EnrollmentEvent {
  final String userId;

  const LoadEnrollmentByUser({required this.userId});

  @override
  List<Object?> get props => [userId];
}

final class AddEnrollment extends EnrollmentEvent {
  final String userId;
  final WorkshopEntity workshop;
  final String paymentStatus;
  final DateTime enrollmentDate;
  final String completionStatus;
  final String? feedback;

  const AddEnrollment({
    required this.userId,
    required this.workshop,
    required this.paymentStatus,
    required this.enrollmentDate,
    required this.completionStatus,
    this.feedback,
  });

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

final class UpdateEnrollment extends EnrollmentEvent {
  final String? id;
  final String userId;
  final WorkshopEntity workshop;
  final String paymentStatus;
  final DateTime enrollmentDate;
  final String completionStatus;
  final String? feedback;

  const UpdateEnrollment({
    required this.id,
    required this.userId,
    required this.workshop,
    required this.paymentStatus,
    required this.enrollmentDate,
    required this.completionStatus,
    this.feedback,
  });

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

final class PayEnrollment extends EnrollmentEvent {
  final String id;
  final String amount;

  const PayEnrollment({
    required this.id,
    required this.amount,
  });

  @override
  List<Object?> get props => [id, amount];
}

final class DeleteEnrollment extends EnrollmentEvent {
  final String id;

  DeleteEnrollment(this.id);

  @override
  List<Object?> get props => [id];
}
