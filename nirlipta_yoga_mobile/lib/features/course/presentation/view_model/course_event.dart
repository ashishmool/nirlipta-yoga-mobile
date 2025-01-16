part of 'course_bloc.dart';

@immutable
sealed class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

final class LoadCourses extends CourseEvent {}

final class AddCourse extends CourseEvent {
  final String courseName;

  const AddCourse(this.courseName);

  @override
  List<Object> get props => [courseName];
}

final class DeleteCourse extends CourseEvent {
  final String courseId;

  const DeleteCourse(this.courseId);

  @override
  List<Object> get props => [courseId];
}
