part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesAndBatches extends RegisterEvent {}

class RegisterUser extends RegisterEvent {
  final String name;
  final String username;
  final String phone;
  final String email;
  final String password;
  final String? photo;
  final String role;
  final String? status;

  // final DateTime? dob;
  final String gender;
  final String medical_conditions;

  const RegisterUser({
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    this.photo,
    required this.role,
    this.status,
    required this.medical_conditions,
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
        role,
        medical_conditions,
        gender,
      ];
}
