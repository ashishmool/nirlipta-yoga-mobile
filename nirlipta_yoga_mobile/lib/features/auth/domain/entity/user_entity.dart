import 'package:equatable/equatable.dart';

import '../../../workshop/domain/entity/workshop_entity.dart';

class StudentEntity extends Equatable {
  final String? id;
  final String name;
  final String? image;
  final String phone;
  final String? gender;

  // final BatchEntity batch;
  final List<WorkshopEntity> workshops;
  final String email;
  final String password;

  const StudentEntity({
    this.id,
    required this.name,
    this.image,
    required this.phone,
    this.gender,
    // required this.batch,
    required this.workshops,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [id, email];
}
