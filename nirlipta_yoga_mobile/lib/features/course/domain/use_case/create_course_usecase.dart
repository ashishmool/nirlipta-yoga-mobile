import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/course_entity.dart';
import '../repository/course_repository.dart';

class CreateCourseParams extends Equatable {
  final String courseName;

  const CreateCourseParams({required this.courseName});

  //Empty Constructor
  const CreateCourseParams.empty() : courseName = '_empty.string';

  @override
  List<Object?> get props => [courseName];
}

class CreateCourseUseCase
    implements UsecaseWithParams<void, CreateCourseParams> {
  final ICourseRepository courseRepository;

  CreateCourseUseCase({required this.courseRepository});

  @override
  Future<Either<Failure, void>> call(CreateCourseParams params) async {
    return await courseRepository
        .createCourse(CourseEntity(courseName: params.courseName));
  }
}
