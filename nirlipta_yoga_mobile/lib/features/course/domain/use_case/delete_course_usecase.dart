import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/course_repository.dart';

class DeleteCourseParams extends Equatable {
  final String courseId;

  const DeleteCourseParams({required this.courseId});

  @override
  List<Object?> get props => [courseId];
}

class DeleteCourseUseCase
    implements UsecaseWithParams<void, DeleteCourseParams> {
  final ICourseRepository courseRepository;

  DeleteCourseUseCase({required this.courseRepository});

  @override
  Future<Either<Failure, void>> call(DeleteCourseParams params) {
    return courseRepository.deleteCourse(params.courseId);
  }
}
