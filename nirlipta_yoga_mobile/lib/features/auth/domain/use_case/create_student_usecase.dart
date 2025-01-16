import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/data/model/workshop_hive_model.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/user_entity.dart';
import '../repository/student_repository.dart';

class CreateStudentParams extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String? image;
  final String gender;
  final List<WorkshopHiveModel> workshops;

  const CreateStudentParams({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    this.image,
    required this.gender,
    required this.workshops,
  });

  @override
  List<Object?> get props => [
        name,
        phone,
        email,
        password,
        image,
        gender,
        workshops,
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
      name: params.name,
      phone: params.phone,
      email: params.email,
      password: params.password,
      image: params.image,
      gender: params.gender,
      workshops:
          params.workshops.map((workshop) => workshop.toEntity()).toList(),
    );

    // Call the repository method to create the student
    return await studentRepository.createStudent(studentEntity);
  }
}
