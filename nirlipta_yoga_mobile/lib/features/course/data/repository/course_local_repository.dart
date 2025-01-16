import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/course_entity.dart';
import '../../domain/repository/course_repository.dart';
import '../data_source/local_datasource/course_local_data_source.dart';

class CourseLocalRepository implements ICourseRepository {
  final CourseLocalDataSource _courseLocalDataSource;

  CourseLocalRepository({required CourseLocalDataSource courseLocalDataSource})
      : _courseLocalDataSource = courseLocalDataSource;

  @override
  Future<Either<Failure, void>> createCourse(CourseEntity course) {
    try {
      _courseLocalDataSource.createCourse(course);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCourse(String courseId) async {
    try {
      await _courseLocalDataSource.deleteCourse(courseId);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Error deleting course: $e'));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() async {
    try {
      final courses = await _courseLocalDataSource.getAllCourses();
      return Right(courses);
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'Error getting all courses: $e'));
    }
  }
}
