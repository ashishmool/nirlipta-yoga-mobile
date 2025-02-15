import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../../workshop/data/model/workshop_hive_model.dart';
import '../../domain/entity/enrollment_entity.dart';

part 'enrollment_hive_model.g.dart';

// Command to Generate Adapter: dart run build_runner build -d
// Run this each time changes are made to the model.

@HiveType(typeId: HiveTableConstant.enrollmentTableId)
class EnrollmentHiveModel extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final WorkshopHiveModel workshop;

  @HiveField(3)
  final String paymentStatus;

  @HiveField(4)
  final DateTime enrollmentDate;

  @HiveField(5)
  final String completionStatus;

  @HiveField(6)
  final String? feedback;

  EnrollmentHiveModel({
    String? id,
    required this.userId,
    required this.workshop,
    this.paymentStatus = "pending",
    DateTime? enrollmentDate,
    this.completionStatus = "not started",
    this.feedback,
  })  : id = id ?? const Uuid().v4(),
        enrollmentDate = enrollmentDate ?? DateTime.now();

  // Initial Constructor with Default Values
  EnrollmentHiveModel.initial()
      : id = '',
        userId = '',
        workshop = WorkshopHiveModel.empty(),
        paymentStatus = "pending",
        enrollmentDate = DateTime(1970, 1, 1),
        // Unix Epoch start
        completionStatus = "not started",
        feedback = null;

  // From Entity
  factory EnrollmentHiveModel.fromEntity(EnrollmentEntity entity) {
    return EnrollmentHiveModel(
      id: entity.id,
      userId: entity.userId,
      workshop: WorkshopHiveModel.fromEntity(entity.workshop),
      // FIXED
      paymentStatus: entity.paymentStatus,
      enrollmentDate: entity.enrollmentDate,
      completionStatus: entity.completionStatus,
      feedback: entity.feedback,
    );
  }

  // To Entity
  EnrollmentEntity toEntity() {
    return EnrollmentEntity(
      id: id,
      userId: userId,
      workshop: workshop.toEntity(),
      // FIXED
      paymentStatus: paymentStatus,
      enrollmentDate: enrollmentDate,
      completionStatus: completionStatus,
      feedback: feedback,
    );
  }

  // Convert List of Entities to List of Hive Models
  static List<EnrollmentHiveModel> fromEntityList(
      List<EnrollmentEntity> entityList) {
    return entityList
        .map((entity) => EnrollmentHiveModel.fromEntity(entity))
        .toList();
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
