import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/user_entity.dart';

part 'user_hive_model.g.dart';
// dart run build_runner build -d

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String username;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String password;

  @HiveField(6)
  final String? photo;

  @HiveField(7)
  final String gender;

  @HiveField(8)
  final List<String>? medicalConditions;

  @HiveField(9)
  final String? otp;

  @HiveField(10)
  final String? role;

  UserHiveModel({
    String? id,
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    this.role,
    required this.password,
    this.photo,
    this.otp,
    required this.gender,
    List<String>? medicalConditions,
  })  : id = id ?? const Uuid().v4(),
        medicalConditions = medicalConditions ?? null;

  UserHiveModel copyWith({
    String? id,
    String? name,
    String? username,
    String? phone,
    String? email,
    String? password,
    String? role,
    String? gender,
    String? photo,
    String? otp,
    String? medicalConditions,
  }) {
    return UserHiveModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      photo: photo ?? this.photo,
      otp: otp ?? this.otp,
      username: username ?? this.username,
      phone: '',
      gender: gender ?? this.gender,
    );
  }

  /// Initial constructor with default values
  const UserHiveModel.initial()
      : id = '',
        name = '',
        username = '',
        phone = '',
        role = '',
        email = '',
        password = '',
        photo = null,
        otp = '',
        gender = '',
        medicalConditions = null;

  /// Convert from entity
  factory UserHiveModel.fromEntity(UserEntity entity) {
    return UserHiveModel(
      id: entity.id ?? const Uuid().v4(),
      name: entity.name,
      username: entity.username,
      phone: entity.phone,
      email: entity.email,
      password: entity.password,
      photo: entity.photo?.isEmpty ?? true ? null : entity.photo,
      // Handle empty image
      gender: entity.gender,
      medicalConditions: entity.medical_conditions,
      role: entity.role,
    );
  }

  /// Convert to entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      username: username,
      phone: phone,
      role: role,
      email: email,
      password: password,
      photo: photo,
      gender: gender,
      medical_conditions: medicalConditions,
    );
  }

  /// Convert a list of entities to Hive models
  static List<UserHiveModel> fromEntityList(List<UserEntity> entityList) {
    return entityList
        .map((entity) => UserHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        phone,
        email,
        password,
        photo,
        gender,
        medicalConditions,
        role,
      ];
}
