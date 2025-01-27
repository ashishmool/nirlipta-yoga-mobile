import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String name;
  final String username;
  final String phone;
  final String email;
  final String password;
  final String? photo;

  // final DateTime? dob;
  final String gender;
  final String medical_conditions;

  const UserEntity({
    this.id,
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    this.photo,
    required this.medical_conditions,
    // this.dob,
    required this.gender,
  });

  @override
  List<Object?> get props => [id, email, username, phone];
}
