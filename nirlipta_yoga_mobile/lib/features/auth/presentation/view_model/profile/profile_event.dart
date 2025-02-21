part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends ProfileEvent {}

class LoadImage extends ProfileEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

class FetchUserById extends ProfileEvent {
  final String userId;

  const FetchUserById({required this.userId});

  @override
  List<Object> get props => [userId];
}

class UpdateUserProfile extends ProfileEvent {
  final String id;
  final String name;
  final String username;
  final String phone;
  final String email;
  final String password;
  final String? photo;

  // final DateTime? dob;
  final String gender;
  final List<String>? medical_conditions;

  const UpdateUserProfile({
    required this.id,
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

  @override
  List<Object> get props => [
        id,
        name,
        username,
        phone,
        email,
        password,
        gender,
      ];
}
