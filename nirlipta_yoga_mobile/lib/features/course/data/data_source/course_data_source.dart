import '../../domain/entity/course_entity.dart';

abstract interface class ICourseDataSource {
  Future<void> createCourse(CourseEntity courseEntity);

  Future<List<CourseEntity>> getAllCourses();

  Future<void> deleteCourse(String courseId);
}
