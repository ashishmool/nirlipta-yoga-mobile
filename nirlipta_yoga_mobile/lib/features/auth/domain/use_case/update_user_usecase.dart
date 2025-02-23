import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/shared_prefs/token_shared_prefs.dart';
import '../../../../app/shared_prefs/user_shared_prefs.dart';
import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
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
    // Fetch user data from SharedPreferences
    final userDataResult = await userSharedPrefs.getUserData();

    return userDataResult.fold(
      (failure) => Left(failure),
      // Return failure if fetching user data fails
      (userData) async {
        if (userData[2] == null || userData[1] == null) {
          return Left(
              SharedPrefsFailure(message: "User ID or Token is missing"));
        }

        final String userId = userData[2]!; // Extract userId
        final String token = userData[1]!; // Extract token

        return await userRepository.updateUser(
          userId,
          token,
          params.toJson(), // Pass the user data
        );
      },
    );
  }
}
