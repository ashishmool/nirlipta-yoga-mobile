import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/course_entity.dart';

part 'course_hive_model.g.dart';
// Command to Generate Adapter: dart run build_runner build -d
// Need to run each time changes are made to Model

@HiveType(typeId: HiveTableConstant.courseTableId)

class CourseHiveModel extends Equatable{
  @HiveField(0)
  final String? courseId;

  @HiveField(1)
  final String courseName;

  CourseHiveModel({
    String? courseId,
    required this.courseName,
  }) : courseId = courseId ?? const Uuid().v4();


  //Initial Constructor
  const CourseHiveModel.initial()
      : courseId = '',
        courseName = '';

  //From Entity
  factory CourseHiveModel.fromEntity(CourseEntity entity){
    return CourseHiveModel(
      courseId: entity.courseId,
      courseName: entity.courseName,
    );
  }

//To Entity
  CourseEntity toEntity(){
    return CourseEntity(
      courseId: courseId,
      courseName: courseName,
    );
  }

// To Entity List
  static List<CourseHiveModel> fromEntityList(List<CourseEntity> entityList){
    return entityList
        .map((entity) => CourseHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [courseId, courseName];


}