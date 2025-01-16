import '../../domain/entity/user_entity.dart';

abstract interface class IStudentDataSource {
  Future<void> createStudent(StudentEntity studentEntity);

  Future<List<StudentEntity>> getAllStudents();

  Future<void> deleteStudent(String id);

  Future<StudentEntity> login(String email, String password);
}
