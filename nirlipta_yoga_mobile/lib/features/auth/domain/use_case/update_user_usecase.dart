import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/shared_prefs/token_shared_prefs.dart';
import '../../../../app/shared_prefs/user_shared_prefs.dart';
import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class UpdateUserParams extends Equatable {
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

  const UpdateUserParams({
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
  UpdateUserParams.empty()
      : id = '_empty.id',
        name = '_empty.name',
        username = '_empty.username',
        phone = '_empty.phone',
        email = '_empty.email',
        password = '_empty.password',
        photo = '_empty.photo',
        medical_conditions = ['None'],
        gender = '_empty.gender';

  @override
  List<Object?> get props => [
        id,
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
      'id': id,
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

class UpdateUserUsecase implements UsecaseWithParams<void, UpdateUserParams> {
  final IUserRepository userRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final UserSharedPrefs userSharedPrefs;

  const UpdateUserUsecase({
    required this.userRepository,
    required this.tokenSharedPrefs,
    required this.userSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(UpdateUserParams params) async {
    final tokenResult = await tokenSharedPrefs.getToken();

    // Handle token retrieval failure
    return tokenResult.fold(
        (failure) => Left(failure),
        (token) async => await userRepository.updateUser(
              UserEntity(
                id: params.id,
                name: params.name,
                username: params.username,
                phone: params.phone,
                email: params.email,
                password: params.password,
                photo: params.photo,
                gender: params.gender,
                medical_conditions: params.medical_conditions,
              ),
              token,
            ));
  }
}
