import 'package:equatable/equatable.dart';

class CourseEntity extends Equatable{
  final String? courseId;
  final String courseName;

  const CourseEntity({
    this.courseId,
    required this.courseName,
});

  @override
  List<Object?> get props => [courseId, courseName];
}