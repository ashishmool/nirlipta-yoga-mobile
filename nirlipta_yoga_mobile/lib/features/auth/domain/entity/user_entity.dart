import 'package:equatable/equatable.dart';

import '../../../batch/domain/entity/batch_entity.dart';
import '../../../course/domain/entity/course_entity.dart';

class StudentEntity extends Equatable {
  final String? id;
  final String fname;
  final String lname;
  final String? image;
  final String phone;
  final BatchEntity batch;
  final List<CourseEntity> courses;
  final String email;
  final String password;

  const StudentEntity({
    this.id,
    required this.fname,
    required this.lname,
    this.image,
    required this.phone,
    required this.batch,
    required this.courses,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [id, email];
}
