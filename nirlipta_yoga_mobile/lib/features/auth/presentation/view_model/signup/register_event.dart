part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesAndBatches extends RegisterEvent {}

class RegisterStudent extends RegisterEvent {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String gender;

  final List<WorkshopHiveModel> workshops;

  const RegisterStudent({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.gender,
    required this.workshops,
  });

  @override
  List<Object> get props => [name, phone, email, password, gender, workshops];
}
