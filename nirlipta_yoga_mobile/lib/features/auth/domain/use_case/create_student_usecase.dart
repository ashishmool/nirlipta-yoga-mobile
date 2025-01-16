import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../../batch/data/model/batch_hive_model.dart';
import '../../../course/data/model/course_hive_model.dart';
import '../entity/user_entity.dart';
import '../repository/student_repository.dart';

class CreateStudentParams extends Equatable {
  final String fName;
  final String lName;
  final String phone;
  final String email;
  final String password;
  final String? image;
  final BatchHiveModel batch;
  final List<CourseHiveModel> courses;

  const CreateStudentParams({
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email,
    required this.password,
    this.image,
    required this.batch,
    required this.courses,
  });

  @override
  List<Object?> get props => [
        fName,
        lName,
        phone,
        email,
        password,
        image,
        batch,
        courses,
      ];
}

class CreateStudentUsecase
    implements UsecaseWithParams<void, CreateStudentParams> {
  final IStudentRepository studentRepository;

  const CreateStudentUsecase({required this.studentRepository});

  @override
  Future<Either<Failure, void>> call(CreateStudentParams params) async {
    // Create the student entity from the params
    final studentEntity = StudentEntity(
      id: null,
      // The ID will be generated automatically
      fname: params.fName,
      lname: params.lName,
      phone: params.phone,
      email: params.email,
      password: params.password,
      image: params.image,
      batch: params.batch.toEntity(),
      courses: params.courses.map((course) => course.toEntity()).toList(),
    );

    // Call the repository method to create the student
    return await studentRepository.createStudent(studentEntity);
  }
}
