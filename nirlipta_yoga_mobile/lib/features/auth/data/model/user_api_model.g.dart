// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      id: json['_id'] as String?,
      otp: json['otp'] as String?,
      name: json['name'] as String,
      role: json['role'] as String?,
      username: json['username'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      photo: json['photo'] as String?,
      gender: json['gender'] as String,
      medical_conditions: (json['medical_conditions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'username': instance.username,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
      'otp': instance.otp,
      'photo': instance.photo,
      'gender': instance.gender,
      'medical_conditions': instance.medical_conditions,
    };
