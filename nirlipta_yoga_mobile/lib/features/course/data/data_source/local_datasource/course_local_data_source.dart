import '../../../../../core/network/hive_service.dart';
import '../../../domain/entity/course_entity.dart';
import '../../model/course_hive_model.dart';
import '../course_data_source.dart';

class CourseLocalDataSource implements ICourseDataSource {
  final HiveService _hiveService;

  CourseLocalDataSource(this._hiveService);

  @override
  Future<void> createCourse(CourseEntity courseEntity) async {
    try {
      final courseHiveModel = CourseHiveModel.fromEntity(courseEntity);
      await _hiveService.addCourse(courseHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<CourseEntity>> getAllCourses() async {
    try {
      return _hiveService.getAllCourses().then((value) =>
          value.map((courseHiveModel) => courseHiveModel.toEntity()).toList());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteCourse(String courseId) async {
    try {
      await _hiveService.deleteCourse(courseId);
    } catch (e) {
      throw Exception(e);
    }
  }
}
