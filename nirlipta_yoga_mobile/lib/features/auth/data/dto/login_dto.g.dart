// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDTO _$LoginDTOFromJson(Map<String, dynamic> json) => LoginDTO(
      success: json['success'] as bool,
      token: json['token'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      user_id: json['user_id'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      photo: json['photo'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$LoginDTOToJson(LoginDTO instance) => <String, dynamic>{
      'success': instance.success,
      'token': instance.token,
      'statusCode': instance.statusCode,
      'user_id': instance.user_id,
      'email': instance.email,
      'role': instance.role,
      'photo': instance.photo,
      'message': instance.message,
    };
