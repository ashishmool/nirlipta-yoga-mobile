import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String name;
  final String username;
  final String phone;
  final String? role;
  final String email;
  final String password;
  final String? photo;
  final String? otp;

  // final DateTime? dob;
  final String gender;
  final List<String>? medical_conditions;

  const UserEntity({
    this.id,
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    this.role,
    this.photo,
    this.otp,
    required this.medical_conditions,
    // this.dob,
    required this.gender,
  });

  // Initialize Empty Constructor
  const UserEntity.empty()
      : id = '_empty.id',
        name = '_empty.name',
        username = '_empty.username',
        phone = '_empty.phone',
        email = '_empty.email',
        password = '_empty.password',
        role = '_empty.role',
        photo = '_empty.photo',
        medical_conditions = null,
        otp = '_empty.otp',
        gender = '_empty.gender';

  @override
  List<Object?> get props => [id, email, username, phone];
}
