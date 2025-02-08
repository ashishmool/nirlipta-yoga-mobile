// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_enrollment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllEnrollmentDTO _$GetAllEnrollmentDTOFromJson(Map<String, dynamic> json) =>
    GetAllEnrollmentDTO(
      enrollments: (json['enrollments'] as List<dynamic>)
          .map((e) => EnrollmentApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$GetAllEnrollmentDTOToJson(
        GetAllEnrollmentDTO instance) =>
    <String, dynamic>{
      'enrollments': instance.enrollments,
      'count': instance.count,
    };
