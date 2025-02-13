// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_enrollment_by_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetEnrollmentByUserDTO _$GetEnrollmentByUserDTOFromJson(
        Map<String, dynamic> json) =>
    GetEnrollmentByUserDTO(
      enrollments: (json['enrollments'] as List<dynamic>)
          .map((e) => EnrollmentApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetEnrollmentByUserDTOToJson(
        GetEnrollmentByUserDTO instance) =>
    <String, dynamic>{
      'enrollments': instance.enrollments,
    };
