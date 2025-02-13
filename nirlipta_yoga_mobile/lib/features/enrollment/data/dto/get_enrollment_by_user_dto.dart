import 'package:json_annotation/json_annotation.dart';

import '../model/enrollment_api_model.dart';

part 'get_enrollment_by_user_dto.g.dart';

@JsonSerializable()
class GetEnrollmentByUserDTO {
  final List<EnrollmentApiModel> enrollments;

  GetEnrollmentByUserDTO({required this.enrollments});

  factory GetEnrollmentByUserDTO.fromJson(List<dynamic> json) {
    return GetEnrollmentByUserDTO(
      enrollments: json.map((e) => EnrollmentApiModel.fromJson(e)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() =>
      enrollments.map((e) => e.toJson()).toList();
}
