// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// import '../../domain/entity/user_entity.dart';
//
// part 'user_api_model.g.dart';
//
// @JsonSerializable()
// class UserApiModel extends Equatable {
//   @JsonKey(name: '_id') // Maps the server field "_id" to the "userId" field
//   final String? id;
//   final String name;
//   final String? role;
//   final String username;
//   final String phone;
//   final String email;
//   final String password;
//   final String? otp;
//
//   // @JsonKey(name: 'photo') // Maps the server field "photo" to the "image" field
//   final String? photo;
//   final String gender;
//   final List<String>? medical_conditions;
//
//   const UserApiModel({
//     this.id,
//     this.otp,
//     required this.name,
//     this.role,
//     required this.username,
//     required this.phone,
//     required this.email,
//     required this.password,
//     this.photo,
//     required this.gender,
//     this.medical_conditions,
//   });
//
//   const UserApiModel.empty()
//       : id = '',
//         name = '',
//         otp = '',
//         username = '',
//         phone = '',
//         role = '',
//         email = '',
//         password = '',
//         photo = '',
//         gender = '',
//         medical_conditions = null;
//
//   /// Factory constructor for creating a `UserApiModel` from JSON
//   factory UserApiModel.fromJson(Map<String, dynamic> json) {
//     return UserApiModel(
//       id: json['_id'] as String?,
//       name: json['name'] as String,
//       otp: json['otp'] as String,
//       username: json['username'] as String,
//       phone: json['phone'] as String,
//       role: json['role'] as String,
//       email: json['email'] as String,
//       password: json['password'] as String,
//       photo: json['photo'] as String?,
//       gender: json['gender'] as String,
//       medical_conditions: List<String>.from(json["medical_conditions"]),
//     );
//   }
//
//   /// Converts the current instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'name': name,
//       'otp': otp,
//       'username': username,
//       'role': role,
//       'phone': phone,
//       'email': email,
//       'password': password,
//       'photo': photo,
//       'gender': gender,
//       'medical_conditions': medical_conditions,
//     };
//   }
//
//   /// Converts the API model to a domain entity
//   UserEntity toEntity() => UserEntity(
//         id: id,
//         name: name,
//         otp: otp,
//         username: username,
//         phone: phone,
//         email: email,
//         password: password,
//         photo: photo,
//         gender: gender,
//         medical_conditions: medical_conditions,
//         role: role,
//       );
//
//   /// Converts a domain entity to an API model
//   factory UserApiModel.fromEntity(UserEntity entity) {
//     return UserApiModel(
//       id: entity.id,
//       name: entity.name,
//       otp: entity.otp,
//       role: entity.role,
//       username: entity.username,
//       phone: entity.phone,
//       email: entity.email,
//       password: entity.password,
//       photo: entity.photo,
//       gender: entity.gender,
//       medical_conditions: entity.medical_conditions,
//     );
//   }
//
//   /// Converts a list of API models to a list of entities
//   static List<UserEntity> toEntityList(List<UserApiModel> models) {
//     return models.map((model) => model.toEntity()).toList();
//   }
//
//   @override
//   List<Object?> get props => [
//         id,
//         name,
//         otp,
//         username,
//         phone,
//         email,
//         password,
//         photo,
//         gender,
//         medical_conditions,
//       ];
// }

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/user_entity.dart';

part 'user_api_model.g.dart';

@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String? role;
  final String username;
  final String phone;
  final String email;
  final String password;
  final String? otp;
  final String? photo;
  final String gender;
  final List<String>? medical_conditions;

  const UserApiModel({
    this.id,
    this.otp,
    required this.name,
    this.role,
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    this.photo,
    required this.gender,
    this.medical_conditions,
  });

  const UserApiModel.empty()
      : id = '',
        name = '',
        otp = '',
        username = '',
        phone = '',
        role = '',
        email = '',
        password = '',
        photo = '',
        gender = '',
        medical_conditions = null;

  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  UserEntity toEntity() => UserEntity(
        id: id,
        name: name,
        otp: otp,
        username: username,
        phone: phone,
        email: email,
        password: password,
        photo: photo,
        gender: gender,
        medical_conditions: medical_conditions ?? [],
        role: role,
      );

  factory UserApiModel.fromEntity(UserEntity entity) {
    return UserApiModel(
      id: entity.id,
      name: entity.name,
      otp: entity.otp,
      role: entity.role,
      username: entity.username,
      phone: entity.phone,
      email: entity.email,
      password: entity.password,
      photo: entity.photo,
      gender: entity.gender,
      medical_conditions: entity.medical_conditions,
    );
  }

  static List<UserEntity> toEntityList(List<UserApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        phone,
        email,
        photo,
        gender,
        medical_conditions,
        role,
      ];
}
