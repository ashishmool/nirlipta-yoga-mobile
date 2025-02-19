import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class CreateUserParams extends Equatable {
  final String? id;
  final String name;
  final String username;
  final String phone;
  final String email;
  final String password;
  final String? photo;

  // final DateTime? dob;
  final String gender;
  final List<String>? medical_conditions;

  const CreateUserParams({
    this.id,
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    this.photo,
    this.medical_conditions,
    // this.dob,
    required this.gender,
  });

  // Initialize Empty Constructor
  const CreateUserParams.empty()
      : id = '_empty.id',
        name = '_empty.name',
        username = '_empty.username',
        phone = '_empty.phone',
        email = '_empty.email',
        password = '_empty.password',
        photo = '_empty.photo',
        medical_conditions = null,
        gender = '_empty.gender';

  @override
  List<Object?> get props => [
        name,
        username,
        phone,
        email,
        password,
        photo,
        medical_conditions,
        gender,
      ];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'username': username,
      'password': password,
      'photo': photo,
      'gender': gender,
      'medical_conditions': medical_conditions,
    };
  }
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
      username: params.username,
      phone: params.phone,
      email: params.email,
      password: params.password,
      photo: params.photo,
      gender: params.gender,
      medical_conditions: params.medical_conditions,
      // dob: params.dob,
    );

    // Call the repository method to create the user
    return await userRepository.createUser(userEntity);
  }
}
