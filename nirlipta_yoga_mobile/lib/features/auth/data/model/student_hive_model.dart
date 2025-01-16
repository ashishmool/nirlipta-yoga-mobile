import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../../batch/data/model/batch_hive_model.dart';
import '../../../course/data/model/course_hive_model.dart';
import '../../domain/entity/user_entity.dart';

part 'student_hive_model.g.dart';
//dart run build_runner build -d

@HiveType(typeId: HiveTableConstant.studentTableId)
class StudentHiveModel extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String fname;

  @HiveField(2)
  final String lname;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  final String phone;

  @HiveField(5)
  final BatchHiveModel batch;

  @HiveField(6)
  final List<CourseHiveModel> courses;

  @HiveField(7)
  final String email;

  @HiveField(8)
  final String password;

  StudentHiveModel({
    String? id,
    required this.fname,
    required this.lname,
    this.image,
    required this.phone,
    required this.batch,
    required this.courses,
    required this.email,
    required this.password,
  }) : id = id ?? const Uuid().v4();

  /// Initial constructor
  const StudentHiveModel.initial()
      : id = '',
        fname = '',
        lname = '',
        image = '',
        phone = '',
        batch = const BatchHiveModel.initial(),
        courses = const [],
        email = '',
        password = '';

  // Convert from entity
  factory StudentHiveModel.fromEntity(StudentEntity entity) {
    return StudentHiveModel(
      id: entity.id,
      fname: entity.fname,
      lname: entity.lname,
      image: entity.image,
      phone: entity.phone,
      batch: BatchHiveModel.fromEntity(entity.batch),
      courses: CourseHiveModel.fromEntityList(entity.courses),
      email: entity.email,
      password: entity.password,
    );
  }

  // Convert to entity
  StudentEntity toEntity() {
    return StudentEntity(
      id: id,
      fname: fname,
      lname: lname,
      image: image,
      phone: phone,
      batch: batch.toEntity(),
      courses: courses.map((course) => course.toEntity()).toList(),
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
        fname,
        lname,
        image,
        phone,
        batch,
        courses,
        email,
        password,
      ];
}
