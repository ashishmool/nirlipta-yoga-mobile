// import 'package:equatable/equatable.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:uuid/uuid.dart';
//
// import '../../../../app/constants/hive_table_constant.dart';
// import '../../domain/entity/student_entity.dart';
//
// @HiveType(typeId: HiveTableConstant.studentTableId)
//
// class AuthHiveModel extends Equatable{
//   @HiveField(0)
//   final String? studentId;
//
//   @HiveField(1)
//   final String studentUsername;
//
//   AuthHiveModel({
//     String? studentId,
//     required this.studentUsername,
//   }) : studentId = studentId ?? const Uuid().v4();
//
//
// //Initial Constructor
//   const AuthHiveModel.initial()
//       : studentId = '',
//         studentUsername = '';
//
//   //From Entity
//   factory AuthHiveModel.fromEntity(StudentEntity entity){
//     return AuthHiveModel(
//       studentId: entity.studentId,
//       studentUsername: entity.username,
//     );
//   }
//
// //To Entity
//   StudentEntity toEntity(){
//     return StudentEntity(
//       studentId: studentId,
//       studentUsername: studentUsername,
//     );
//   }
//
// // To Entity List
//   static List<AuthHiveModel> fromEntityList(List<AuthEntity> entityList){
//     return entityList
//         .map((entity) => AuthHiveModel.fromEntity(entity))
//         .toList();
//   }
//
//   @override
//   List<Object?> get props => [studentId, studentUsername];
//
//
// }