import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginDTO {
  final bool success;
  final String token;
  final int statusCode;

  // final String user_id;
  // final String email;
  // final String role;
  // final String? image;
  // final String message;

  LoginDTO({
    required this.success,
    required this.token,
    required this.statusCode,

    // required this.user_id,
    // required this.email,
    // required this.role,
    // this.image,
    // required this.message,
  });

  /// Factory constructor for creating a `LoginDTO` from JSON
  factory LoginDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginDTOFromJson(json);

  /// Converts the current instance to JSON
  Map<String, dynamic> toJson() => _$LoginDTOToJson(this);
}
