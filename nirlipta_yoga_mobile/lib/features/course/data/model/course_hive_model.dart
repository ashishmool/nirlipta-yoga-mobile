import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/course_entity.dart';

part 'course_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.courseTableId)
class CourseHiveModel extends Equatable {
  @HiveField(0)
  final String? courseId;

  @HiveField(1)
  final String courseName;

  CourseHiveModel({
    String? courseId,
    required this.courseName,
  }) : courseId = courseId ?? const Uuid().v4();

  factory CourseHiveModel.fromEntity(CourseEntity entity) {
    return CourseHiveModel(
      courseId: entity.courseId,
      courseName: entity.courseName,
    );
  }

  CourseEntity toEntity() {
    return CourseEntity(
      courseId: courseId,
      courseName: courseName,
    );
  }

  // Convert List of CourseEntity to List of CourseHiveModel
  static List<CourseHiveModel> fromEntityList(List<CourseEntity> courses) {
    return courses.map((course) => CourseHiveModel.fromEntity(course)).toList();
  }

  // Convert List of CourseHiveModel to List of CourseEntity
  static List<CourseEntity> toEntityList(List<CourseHiveModel> courses) {
    return courses.map((course) => course.toEntity()).toList();
  }

  @override
  List<Object?> get props => [courseId, courseName];
}
