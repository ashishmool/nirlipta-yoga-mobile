import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/data/model/workshop_hive_model.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/user_entity.dart';

part 'student_hive_model.g.dart';
// dart run build_runner build -d

@HiveType(typeId: HiveTableConstant.studentTableId)
class StudentHiveModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? image;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String? gender;

  @HiveField(5)
  final List<WorkshopHiveModel> workshops;

  @HiveField(6)
  final String email;

  @HiveField(7)
  final String password;

  @HiveField(8)
  final String medicalCondition;

  StudentHiveModel({
    String? id,
    required this.name,
    this.image,
    required this.phone,
    this.gender,
    String? medicalCondition,
    // DateTime? dob,
    required this.workshops,
    required this.email,
    required this.password,
  })  : id = id ?? const Uuid().v4(),
        medicalCondition = medicalCondition ?? "None";

  /// Initial constructor with default values
  const StudentHiveModel.initial()
      : id = '',
        name = '',
        image = null,
        medicalCondition = '',
        phone = '',
        gender = null,
        workshops = const [],
        email = '',
        password = '';

  // Convert from entity
  factory StudentHiveModel.fromEntity(StudentEntity entity) {
    return StudentHiveModel(
      id: entity.id ?? const Uuid().v4(),
      name: entity.name,
      image: entity.image?.isEmpty ?? true ? null : entity.image,
      // Handle empty image strings
      phone: entity.phone,
      gender: entity.gender,
      medicalCondition: entity.medicalCondition,
      // dob: entity.dob,
      workshops: WorkshopHiveModel.fromEntityList(entity.workshops),
      email: entity.email,
      password: entity.password,
    );
  }

  // Convert to entity
  StudentEntity toEntity() {
    return StudentEntity(
      id: id,
      name: name,
      image: image,
      medicalCondition: medicalCondition,
      // dob: dob,
      phone: phone,
      gender: gender,
      workshops: workshops.map((workshop) => workshop.toEntity()).toList(),
      email: email,
      password: password,
    );
  }

  static List<StudentHiveModel> fromEntityList(List<StudentEntity> entityList) {
    return entityList
        .map((entity) => StudentHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        medicalCondition,
        // dob,
        phone,
        gender,
        workshops,
        email,
        password,
      ];
}
