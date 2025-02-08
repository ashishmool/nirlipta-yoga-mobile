import 'package:equatable/equatable.dart';

class EnrollmentEntity extends Equatable {
  final String? id;
  final String userId;
  final String workshopId;
  final String paymentStatus;
  final DateTime enrollmentDate;
  final String completionStatus;
  final String? feedback;

  EnrollmentEntity({
    this.id,
    required this.userId,
    required this.workshopId,
    this.paymentStatus = "pending",
    DateTime? enrollmentDate,
    this.completionStatus = "not started",
    this.feedback,
  }) : enrollmentDate = enrollmentDate ?? DateTime.now();

  // Empty Constructor with default values
  factory EnrollmentEntity.empty() {
    return EnrollmentEntity(
      id: '_empty.id',
      userId: '_empty.userId',
      workshopId: '_empty.workshopId',
      paymentStatus: "pending",
      enrollmentDate: DateTime(1970, 1, 1),
      completionStatus: "not started",
      feedback: null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        workshopId,
        paymentStatus,
        enrollmentDate,
        completionStatus,
        feedback,
      ];
}
