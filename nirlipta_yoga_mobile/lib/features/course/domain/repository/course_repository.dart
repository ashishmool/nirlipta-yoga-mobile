import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/course_entity.dart';

abstract interface class ICourseRepository {
  Future<Either<Failure, void>> createCourse(CourseEntity courseEntity);

  Future<Either<Failure, List<CourseEntity>>> getAllCourses();

  Future<Either<Failure, void>> deleteCourse(String courseId);
}
