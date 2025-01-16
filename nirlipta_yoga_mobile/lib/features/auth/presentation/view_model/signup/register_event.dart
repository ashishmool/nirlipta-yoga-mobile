part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesAndBatches extends RegisterEvent {}

class RegisterStudent extends RegisterEvent {
  final String fName;
  final String lName;
  final String phone;
  final String email;
  final String password;
  final BatchHiveModel batch;
  final List<CourseHiveModel> courses;

  const RegisterStudent({
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email,
    required this.password,
    required this.batch,
    required this.courses,
  });

  @override
  List<Object> get props =>
      [fName, lName, phone, email, password, batch, courses];
}
