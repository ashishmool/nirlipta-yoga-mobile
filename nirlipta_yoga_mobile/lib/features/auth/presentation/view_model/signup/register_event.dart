part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesAndBatches extends RegisterEvent {}

class RegisterUser extends RegisterEvent {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String? gender;

  final List<WorkshopHiveModel> workshops;

  const RegisterUser({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    this.gender,
    required this.workshops,
  });

  @override
  List<Object> get props => [name, phone, email, password, workshops];
}
