import 'package:json_annotation/json_annotation.dart';

import '../model/enrollment_api_model.dart';

part 'get_all_enrollment_dto.g.dart';

@JsonSerializable()
class GetAllEnrollmentDTO {
  final List<EnrollmentApiModel> enrollments;
  final int count;

  GetAllEnrollmentDTO({required this.enrollments, required this.count});

  factory GetAllEnrollmentDTO.fromJson(Map<String, dynamic> json) {
    return GetAllEnrollmentDTO(
      enrollments: (json['enrollments'] as List)
          .map((e) => EnrollmentApiModel.fromJson(e))
          .toList(),
      count: json['count'],
    );
  }

  List<Map<String, dynamic>> toJson() =>
      enrollments.map((e) => e.toJson()).toList();
}
