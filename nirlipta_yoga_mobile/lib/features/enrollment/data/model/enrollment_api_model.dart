import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/enrollment_entity.dart';

@JsonSerializable()
class EnrollmentApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'workshop_id')
  final String workshopId;
  @JsonKey(name: 'payment_status')
  final String paymentStatus;
  @JsonKey(name: 'enrollment_date')
  final DateTime enrollmentDate;
  @JsonKey(name: 'completion_status')
  final String completionStatus;
  final String? feedback;

  const EnrollmentApiModel(
      {this.id,
      required this.userId,
      required this.workshopId,
      this.paymentStatus = "pending",
      required this.enrollmentDate,
      this.completionStatus = "not started",
      this.feedback});

  /// Empty Constructor with default values
  EnrollmentApiModel.empty()
      : id = null,
        userId = '',
        workshopId = '',
        paymentStatus = "pending",
        enrollmentDate = DateTime(1970, 1, 1),
        // Default to Unix Epoch
        completionStatus = "not started",
        feedback = null;

  // From JSON
  factory EnrollmentApiModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentApiModel(
      id: json['_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? "",
      workshopId:
          (json['workshop_id'] as Map<String, dynamic>?)?['_id'] as String? ??
              "",
      enrollmentDate: json['enrollment_date'] != null
          ? DateTime.parse(json['enrollment_date'] as String)
          : DateTime.now(),
      completionStatus: json['completion_status'] as String? ?? "not started",
      paymentStatus: json['payment_status'] as String? ?? "pending",
      feedback: json['feedback'] as String?,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'workshop_id': workshopId,
      'enrollment_date': enrollmentDate,
      'completion_status': completionStatus,
      'payment_status': paymentStatus,
      'feedback': feedback,
    };
  }

  // Convert API Object to Entity
  EnrollmentEntity toEntity() => EnrollmentEntity(
        id: id,
        userId: userId,
        workshopId: workshopId,
        paymentStatus: paymentStatus,
        enrollmentDate: enrollmentDate,
        completionStatus: completionStatus,
        feedback: feedback,
      );

  // Convert Entity to API Object
  factory EnrollmentApiModel.fromEntity(EnrollmentEntity enrollment) {
    return EnrollmentApiModel(
      id: enrollment.id,
      userId: enrollment.userId,
      workshopId: enrollment.workshopId,
      paymentStatus: enrollment.paymentStatus,
      enrollmentDate: enrollment.enrollmentDate,
      completionStatus: enrollment.completionStatus,
      feedback: enrollment.feedback,
    );
  }

  // Convert API List to Entity List (handles null and empty lists safely)
  static List<EnrollmentEntity> toEntityList(List<EnrollmentApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
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
