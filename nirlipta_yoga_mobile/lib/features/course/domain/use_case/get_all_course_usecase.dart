import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/course_entity.dart';
import '../repository/course_repository.dart';

class GetAllCourseUseCase implements UsecaseWithoutParams<List<CourseEntity>> {
  final ICourseRepository courseRepository;

  GetAllCourseUseCase({required this.courseRepository});

  @override
  Future<Either<Failure, List<CourseEntity>>> call() {
    return courseRepository.getAllCourses();
  }
}
