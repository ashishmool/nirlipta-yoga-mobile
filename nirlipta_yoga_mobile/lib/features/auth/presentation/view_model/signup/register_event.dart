part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends RegisterEvent {}

class LoadImage extends RegisterEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

class RegisterUser extends RegisterEvent {
  final String name;
  final String username;
  final String phone;
  final String email;
  final String password;
  final String? photo;

  // final DateTime? dob;
  final String gender;
  final List<String>? medical_conditions;

  const RegisterUser({
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
        name,
        username,
        phone,
        email,
        password,
        gender,
      ];
}
