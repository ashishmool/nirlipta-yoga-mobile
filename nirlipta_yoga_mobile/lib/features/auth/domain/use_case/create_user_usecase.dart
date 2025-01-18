import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/data/model/workshop_hive_model.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class CreateUserParams extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String? image;
  final String? medicalCondition;

  // final DateTime? dob;
  final String? gender;
  final List<WorkshopHiveModel> workshops;

  const CreateUserParams({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    this.image,
    this.medicalCondition,
    // this.dob,
    this.gender,
    required this.workshops,
  });

  @override
  List<Object?> get props => [
        name,
        phone,
        email,
        password,
        image,
        medicalCondition,
        // dob,
        gender,
        workshops,
      ];
}

class CreateUserUsecase implements UsecaseWithParams<void, CreateUserParams> {
  final IUserRepository userRepository;

  const CreateUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(CreateUserParams params) async {
    // Create the user entity from the params
    final userEntity = UserEntity(
      id: null,
      // The ID will be generated automatically
      name: params.name,
      phone: params.phone,
      email: params.email,
      password: params.password,
      image: params.image,
      medicalCondition: params.medicalCondition,
      // dob: params.dob,
      gender: params.gender,
      workshops:
          params.workshops.map((workshop) => workshop.toEntity()).toList(),
    );

    // Call the repository method to create the user
    return await userRepository.createUser(userEntity);
  }
}
