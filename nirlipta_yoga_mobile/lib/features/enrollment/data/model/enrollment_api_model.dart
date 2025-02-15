// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:nirlipta_yoga_mobile/features/workshop/data/model/workshop_api_model.dart';
//
// import '../../domain/entity/enrollment_entity.dart';
//
// part 'enrollment_api_model.g.dart';
//
// @JsonSerializable()
// class EnrollmentApiModel extends Equatable {
//   @JsonKey(name: '_id')
//   final String? id;
//   @JsonKey(name: 'user_id')
//   final String userId;
//   @JsonKey(name: 'workshop_id')
//   final WorkshopApiModel workshop;
//   @JsonKey(name: 'payment_status')
//   final String paymentStatus;
//   @JsonKey(name: 'enrollment_date')
//   final DateTime enrollmentDate;
//   @JsonKey(name: 'completion_status')
//   final String completionStatus;
//   final String? feedback;
//
//   const EnrollmentApiModel(
//       {this.id,
//       required this.userId,
//       required this.workshop,
//       this.paymentStatus = "pending",
//       required this.enrollmentDate,
//       this.completionStatus = "not started",
//       this.feedback});
//
//   /// Empty Constructor with default values
//   EnrollmentApiModel.empty()
//       : id = null,
//         userId = '',
//         workshop = WorkshopApiModel.empty(),
//         paymentStatus = "pending",
//         enrollmentDate = DateTime(1970, 1, 1),
//         // Default to Unix Epoch
//         completionStatus = "not started",
//         feedback = null;
//
//   // From JSON
//   factory EnrollmentApiModel.fromJson(Map<String, dynamic> json) {
//     return EnrollmentApiModel(
//       id: json['_id'] as String? ?? '',
//       userId: json['user_id'] as String? ?? "",
//       workshop:
//           (json['workshop_id'] as Map<String, dynamic>?)?['_id'] as String? ??
//               "",
//       enrollmentDate: json['enrollment_date'] != null
//           ? DateTime.parse(json['enrollment_date'] as String)
//           : DateTime.now(),
//       completionStatus: json['completion_status'] as String? ?? "not started",
//       paymentStatus: json['payment_status'] as String? ?? "pending",
//       feedback: json['feedback'] as String?,
//     );
//   }
//
//   // To JSON
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'user_id': userId,
//       'workshop_id': workshop,
//       'enrollment_date': enrollmentDate,
//       'completion_status': completionStatus,
//       'payment_status': paymentStatus,
//       'feedback': feedback,
//     };
//   }
//
//   // Convert API Object to Entity
//   EnrollmentEntity toEntity() => EnrollmentEntity(
//         id: id,
//         userId: userId,
//         workshop: workshop.toEntity(),
//         paymentStatus: paymentStatus,
//         enrollmentDate: enrollmentDate,
//         completionStatus: completionStatus,
//         feedback: feedback,
//       );
//
//   // Convert Entity to API Object
//   factory EnrollmentApiModel.fromEntity(EnrollmentEntity enrollment) {
//     return EnrollmentApiModel(
//       id: enrollment.id,
//       userId: enrollment.userId,
//       workshop: WorkshopApiModel.fromEntity(enrollment.workshop),
//       paymentStatus: enrollment.paymentStatus,
//       enrollmentDate: enrollment.enrollmentDate,
//       completionStatus: enrollment.completionStatus,
//       feedback: enrollment.feedback,
//     );
//   }
//
//   // Convert API List to Entity List (handles null and empty lists safely)
//   static List<EnrollmentEntity> toEntityList(List<EnrollmentApiModel> models) {
//     return models.map((model) => model.toEntity()).toList();
//   }
//
//   @override
//   List<Object?> get props => [
//         id,
//         userId,
//         workshop,
//         paymentStatus,
//         enrollmentDate,
//         completionStatus,
//         feedback,
//       ];
// }

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/data/model/workshop_api_model.dart';

import '../../domain/entity/enrollment_entity.dart';

part 'enrollment_api_model.g.dart';

@JsonSerializable()
class EnrollmentApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'workshop_id')
  final WorkshopApiModel workshop;
  @JsonKey(name: 'payment_status')
  final String paymentStatus;
  @JsonKey(name: 'enrollment_date')
  final DateTime enrollmentDate;
  @JsonKey(name: 'completion_status')
  final String completionStatus;
  final String? feedback;

  const EnrollmentApiModel({
    this.id,
    required this.userId,
    required this.workshop,
    this.paymentStatus = "pending",
    required this.enrollmentDate,
    this.completionStatus = "not started",
    this.feedback,
  });

  /// Empty Constructor with default values
  EnrollmentApiModel.empty()
      : id = null,
        userId = '',
        workshop = WorkshopApiModel.empty(),
        paymentStatus = "pending",
        enrollmentDate = DateTime(1970, 1, 1),
        // Default to Unix Epoch
        completionStatus = "not started",
        feedback = null;

  /// From JSON
  // factory EnrollmentApiModel.fromJson(Map<String, dynamic> json) =>
  //     _$EnrollmentApiModelFromJson(json);
  factory EnrollmentApiModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentApiModel(
      id: json['_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      workshop: json['workshop_id'] != null
          ? WorkshopApiModel.fromJson(
              json['workshop_id'] as Map<String, dynamic>)
          : WorkshopApiModel.empty(),
      // Ensure it's always an object
      enrollmentDate: json['enrollment_date'] != null
          ? DateTime.tryParse(json['enrollment_date'] as String) ??
              DateTime.now()
          : DateTime.now(),
      completionStatus: json['completion_status'] as String? ?? "not started",
      paymentStatus: json['payment_status'] as String? ?? "pending",
      feedback: json['feedback'] as String?,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() => _$EnrollmentApiModelToJson(this);

  /// Convert API Object to Entity
  EnrollmentEntity toEntity() => EnrollmentEntity(
        id: id,
        userId: userId,
        workshop: workshop.toEntity(),
        paymentStatus: paymentStatus,
        enrollmentDate: enrollmentDate,
        completionStatus: completionStatus,
        feedback: feedback,
      );

  /// Convert Entity to API Object
  factory EnrollmentApiModel.fromEntity(EnrollmentEntity enrollment) {
    return EnrollmentApiModel(
      id: enrollment.id,
      userId: enrollment.userId,
      workshop: WorkshopApiModel.fromEntity(enrollment.workshop),
      paymentStatus: enrollment.paymentStatus,
      enrollmentDate: enrollment.enrollmentDate,
      completionStatus: enrollment.completionStatus,
      feedback: enrollment.feedback,
    );
  }

  /// Convert API List to Entity List
  static List<EnrollmentEntity> toEntityList(List<EnrollmentApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
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
