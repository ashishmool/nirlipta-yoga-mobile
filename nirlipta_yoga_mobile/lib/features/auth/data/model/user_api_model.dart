import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/user_entity.dart';

@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name: '_id') // Maps the server field "_id" to the "userId" field
  final String? id;
  final String name;
  final String username;
  final String phone;
  final String email;
  final String password;
  final String? photo;
  final String role;
  final String gender;
  final String medical_conditions;
  final String status;

  const UserApiModel({
    this.id,
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    this.photo,
    this.role = 'student',
    required this.gender,
    this.medical_conditions = 'None',
    this.status = 'active',
  });

  const UserApiModel.empty()
      : id = null,
        name = '',
        username = '',
        phone = '',
        email = '',
        password = '',
        photo = null,
        role = 'student',
        gender = '',
        medical_conditions = 'None',
        status = 'active';

  /// Factory constructor for creating a `UserApiModel` from JSON
  factory UserApiModel.fromJson(Map<String, dynamic> json) {
    return UserApiModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      username: json['username'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      photo: json['photo'] as String?,
      role: json['role'] as String? ?? 'student',
      gender: json['gender'] as String,
      medical_conditions: json['medical_conditions'] as String? ?? 'None',
      status: json['status'] as String? ?? 'active',
    );
  }

  /// Converts the current instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'username': username,
      'phone': phone,
      'email': email,
      'password': password,
      'photo': photo,
      'role': role,
      'gender': gender,
      'medical_conditions': medical_conditions,
      'status': status,
    };
  }

  /// Converts the API model to a domain entity
  UserEntity toEntity() => UserEntity(
        id: id,
        name: name,
        username: username,
        phone: phone,
        email: email,
        password: password,
        photo: photo,
        role: role,
        gender: gender,
        medical_conditions: medical_conditions,
        status: status,
      );

  /// Converts a domain entity to an API model
  factory UserApiModel.fromEntity(UserEntity entity) {
    return UserApiModel(
      id: entity.id,
      name: entity.name,
      username: entity.username,
      phone: entity.phone,
      email: entity.email,
      password: entity.password,
      photo: entity.photo,
      role: entity.role,
      gender: entity.gender,
      medical_conditions: entity.medical_conditions,
    );
  }

  /// Converts a list of API models to a list of entities
  static List<UserEntity> toEntityList(List<UserApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
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
        role,
        gender,
        medical_conditions,
        status,
      ];
}
