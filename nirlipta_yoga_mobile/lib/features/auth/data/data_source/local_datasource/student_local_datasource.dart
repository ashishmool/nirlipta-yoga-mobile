import '../../../../../core/network/hive_service.dart';
import '../../../domain/entity/user_entity.dart';
import '../../model/student_hive_model.dart';
import '../student_data_source.dart';

class StudentLocalDatasource implements IStudentDataSource {
  final HiveService _hiveService;

  StudentLocalDatasource(this._hiveService);

  @override
  Future<void> createStudent(studentEntity) async {
    try {
      final studentHiveModel = StudentHiveModel.fromEntity(studentEntity);
      await _hiveService.addStudent(studentHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteStudent(String id) async {
    try {
      return await _hiveService.deleteStudent(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<StudentEntity>> getAllStudents() async {
    try {
      return await _hiveService.getAllStudents().then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<StudentEntity> login(String email, String password) async {
    try {
      final studentHiveModel = await _hiveService.loginStudent(email, password);
      return studentHiveModel!.toEntity();
    } catch (e) {
      throw Exception(e);
    }
  }
}
