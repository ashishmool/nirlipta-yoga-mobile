// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnrollmentApiModel _$EnrollmentApiModelFromJson(Map<String, dynamic> json) =>
    EnrollmentApiModel(
      id: json['_id'] as String?,
      userId: json['user_id'] as String,
      workshop: WorkshopApiModel.fromJson(
          json['workshop_id'] as Map<String, dynamic>),
      paymentStatus: json['payment_status'] as String? ?? "pending",
      enrollmentDate: DateTime.parse(json['enrollment_date'] as String),
      completionStatus: json['completion_status'] as String? ?? "not started",
      feedback: json['feedback'] as String?,
    );

Map<String, dynamic> _$EnrollmentApiModelToJson(EnrollmentApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'workshop_id': instance.workshop,
      'payment_status': instance.paymentStatus,
      'enrollment_date': instance.enrollmentDate.toIso8601String(),
      'completion_status': instance.completionStatus,
      'feedback': instance.feedback,
    };
