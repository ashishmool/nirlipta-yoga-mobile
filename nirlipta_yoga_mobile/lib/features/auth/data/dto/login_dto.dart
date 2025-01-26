import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginDTO {
  final bool success;
  final String token;

  LoginDTO({
    required this.success,
    required this.token,
  });

  Map<String, dynamic> toJson() => _$LoginDTOToJson(this);

  factory LoginDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginDTOFromJson(json);
}
